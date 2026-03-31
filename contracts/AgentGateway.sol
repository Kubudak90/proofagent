// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./AgentCredential.sol";
import "./ProofVerifier.sol";

/// @title AgentGateway — Authorization entry point for AI agents on Base
/// @notice Combines credential validation + ZK proof verification in a single call.
///         Designed for integration with Coinbase x402 payment protocol.
contract AgentGateway {

    // ─── State ───────────────────────────────────────────────────────

    AgentCredential public immutable credential;
    ProofVerifier   public immutable verifier;

    /// @notice Per-agent rate limiting: agent → window start timestamp
    mapping(address => uint256) public rateLimitWindowStart;
    /// @notice Per-agent rate limiting: agent → request count in current window
    mapping(address => uint256) public rateLimitCount;

    /// @notice Per-agent cumulative spend tracking: agent → total spent in current period
    mapping(address => uint256) public agentSpent;
    /// @notice Per-agent spend period start: agent → period start timestamp
    mapping(address => uint256) public spendPeriodStart;

    /// @notice Maximum requests per agent per hour
    uint256 public constant RATE_LIMIT_PER_HOUR = 100;
    /// @notice Rate limit window duration (1 hour)
    uint256 public constant RATE_LIMIT_WINDOW = 1 hours;
    /// @notice Spend tracking period (24 hours)
    uint256 public constant SPEND_PERIOD = 24 hours;

    /// @notice Total authorizations processed (metric for grants reporting)
    uint256 public totalAuthorizations;

    /// @notice Contract admin
    address public immutable admin;

    // ─── Events ──────────────────────────────────────────────────────

    event AgentAuthorized(
        address indexed agent,
        uint256 indexed credentialId,
        uint256 amount,
        uint256 timestamp
    );

    event X402PaymentAuthorized(
        address indexed agent,
        address indexed recipient,
        uint256 amount,
        bytes32 paymentHash
    );

    // ─── Errors ──────────────────────────────────────────────────────

    error InvalidCredential(uint256 credentialId);
    error CredentialExpired(uint256 credentialId);
    error BudgetExceeded(uint256 requested, uint256 remaining);
    error RateLimitExceeded(address agent);
    error AgentMismatch(address expected, address actual);

    // ─── Constructor ─────────────────────────────────────────────────

    /// @param _credential Address of the AgentCredential SBT contract.
    /// @param _verifier   Address of the ProofVerifier contract.
    constructor(address _credential, address _verifier) {
        credential = AgentCredential(_credential);
        verifier   = ProofVerifier(_verifier);
        admin      = msg.sender;
    }

    // ─── Core Authorization ──────────────────────────────────────────

    /// @notice Authorize an agent action by verifying credential + ZK proof + budget.
    /// @param credentialId  The agent's SBT credential token ID.
    /// @param proof         Groth16 ZK proof of authorization.
    /// @param signals       Public signals from the ZK proof.
    /// @param nullifier     Unique nullifier to prevent proof replay.
    /// @param requestedAmount The amount the agent wants to spend (in wei).
    /// @return authorized True if all checks pass.
    function authorizeAgent(
        uint256 credentialId,
        ProofVerifier.Proof calldata proof,
        ProofVerifier.PublicSignals calldata signals,
        bytes32 nullifier,
        uint256 requestedAmount
    ) public returns (bool authorized) {
        // 1. Rate limiting
        _checkRateLimit(msg.sender);

        // 2. Credential validity
        if (!credential.isValid(credentialId)) revert InvalidCredential(credentialId);

        AgentCredential.AgentPolicy memory policy = credential.getPolicy(credentialId);

        // 3. Verify caller is the agent bound to this credential
        if (policy.agent != msg.sender) revert AgentMismatch(policy.agent, msg.sender);

        // 4. Check expiry
        if (block.timestamp >= policy.expiry) revert CredentialExpired(credentialId);

        // 5. Check budget
        uint256 remaining = _getRemainingBudget(msg.sender, policy.maxBudget);
        if (requestedAmount > remaining) revert BudgetExceeded(requestedAmount, remaining);

        // 6. Verify ZK proof
        verifier.verifyAgentProof(proof, signals, nullifier);

        // 7. Record spend
        _recordSpend(msg.sender, requestedAmount);

        // 8. Update metrics
        totalAuthorizations++;

        emit AgentAuthorized(msg.sender, credentialId, requestedAmount, block.timestamp);

        return true;
    }

    /// @notice x402-compatible authorization for Coinbase payment protocol.
    /// @dev Wraps authorizeAgent with x402-specific parameters.
    /// @param credentialId  Agent's credential.
    /// @param proof         ZK proof.
    /// @param signals       Public signals.
    /// @param nullifier     Replay prevention.
    /// @param recipient     Payment recipient address.
    /// @param amount        Payment amount in wei.
    /// @param token         ERC-20 token address (address(0) for ETH).
    /// @return paymentHash  Hash of the authorized payment for x402 protocol reference.
    function x402Authorize(
        uint256 credentialId,
        ProofVerifier.Proof calldata proof,
        ProofVerifier.PublicSignals calldata signals,
        bytes32 nullifier,
        address recipient,
        uint256 amount,
        address token
    ) external returns (bytes32 paymentHash) {
        // Run full authorization
        authorizeAgent(credentialId, proof, signals, nullifier, amount);

        // Generate x402 payment hash
        paymentHash = keccak256(
            abi.encodePacked(
                msg.sender,     // agent
                recipient,
                amount,
                token,
                block.timestamp,
                block.chainid
            )
        );

        emit X402PaymentAuthorized(msg.sender, recipient, amount, paymentHash);

        return paymentHash;
    }

    // ─── View Functions ──────────────────────────────────────────────

    /// @notice Get the remaining budget for an agent in the current period.
    function getRemainingBudget(
        address agent,
        uint256 credentialId
    ) external view returns (uint256) {
        AgentCredential.AgentPolicy memory policy = credential.getPolicy(credentialId);
        return _getRemainingBudget(agent, policy.maxBudget);
    }

    /// @notice Get the number of requests remaining in the current rate limit window.
    function getRemainingRequests(address agent) external view returns (uint256) {
        if (block.timestamp >= rateLimitWindowStart[agent] + RATE_LIMIT_WINDOW) {
            return RATE_LIMIT_PER_HOUR;
        }
        uint256 used = rateLimitCount[agent];
        return used >= RATE_LIMIT_PER_HOUR ? 0 : RATE_LIMIT_PER_HOUR - used;
    }

    // ─── Internal ────────────────────────────────────────────────────

    function _checkRateLimit(address agent) internal {
        if (block.timestamp >= rateLimitWindowStart[agent] + RATE_LIMIT_WINDOW) {
            // New window
            rateLimitWindowStart[agent] = block.timestamp;
            rateLimitCount[agent] = 1;
        } else {
            rateLimitCount[agent]++;
            if (rateLimitCount[agent] > RATE_LIMIT_PER_HOUR) {
                revert RateLimitExceeded(agent);
            }
        }
    }

    function _getRemainingBudget(
        address agent,
        uint256 maxBudget
    ) internal view returns (uint256) {
        if (block.timestamp >= spendPeriodStart[agent] + SPEND_PERIOD) {
            return maxBudget; // New period, full budget available
        }
        uint256 spent = agentSpent[agent];
        return spent >= maxBudget ? 0 : maxBudget - spent;
    }

    function _recordSpend(address agent, uint256 amount) internal {
        if (block.timestamp >= spendPeriodStart[agent] + SPEND_PERIOD) {
            // New period
            spendPeriodStart[agent] = block.timestamp;
            agentSpent[agent] = amount;
        } else {
            agentSpent[agent] += amount;
        }
    }
}
