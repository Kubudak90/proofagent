// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title AgentCredential — Soul Bound Token (ERC-5192) for AI Agent Authorization
/// @notice Non-transferable credential that binds an authorization policy to an AI agent wallet.
/// @dev Implements ERC-5192 (Minimal Soulbound NFTs) by locking all tokens at mint time.
contract AgentCredential is ERC721, Ownable {

    // ─── Types ───────────────────────────────────────────────────────

    struct AgentPolicy {
        address owner;        // Human principal who issued the credential
        address agent;        // AI agent wallet address
        uint256 maxBudget;    // Maximum spending budget in wei
        uint256 expiry;       // Expiration timestamp (unix seconds)
        bytes32 scopeHash;    // Keccak256 hash of allowed scope (protocols, action types)
        bool active;          // Can be revoked by owner
    }

    // ─── State ───────────────────────────────────────────────────────

    uint256 private _nextTokenId;

    /// @notice tokenId → policy details
    mapping(uint256 => AgentPolicy) public policies;

    /// @notice agent address → active tokenId (0 = none)
    mapping(address => uint256) public agentToToken;

    // ─── Events ──────────────────────────────────────────────────────

    event CredentialIssued(
        uint256 indexed tokenId,
        address indexed owner,
        address indexed agent,
        uint256 maxBudget,
        uint256 expiry
    );

    event CredentialRevoked(uint256 indexed tokenId, address indexed agent);

    /// @dev ERC-5192 event — emitted when a token's lock status changes.
    event Locked(uint256 indexed tokenId);

    // ─── Errors ──────────────────────────────────────────────────────

    error SoulBoundTransferBlocked();
    error AgentAlreadyHasCredential(address agent);
    error OnlyPolicyOwner();
    error CredentialNotActive(uint256 tokenId);

    // ─── Constructor ─────────────────────────────────────────────────

    constructor()
        ERC721("ProofAgent Credential", "PAGENT")
        Ownable(msg.sender)
    {
        _nextTokenId = 1; // token 0 is reserved as "no credential"
    }

    // ─── Core Functions ──────────────────────────────────────────────

    /// @notice Issue a new authorization credential to an AI agent.
    /// @param agent   Wallet address of the AI agent.
    /// @param policy  The full authorization policy to bind.
    /// @return tokenId The minted SBT token ID.
    function issueCredential(
        address agent,
        AgentPolicy calldata policy
    ) external returns (uint256 tokenId) {
        if (agentToToken[agent] != 0) revert AgentAlreadyHasCredential(agent);

        tokenId = _nextTokenId++;

        // Store policy — override owner/agent/active to ensure correctness
        policies[tokenId] = AgentPolicy({
            owner: msg.sender,
            agent: agent,
            maxBudget: policy.maxBudget,
            expiry: policy.expiry,
            scopeHash: policy.scopeHash,
            active: true
        });

        agentToToken[agent] = tokenId;

        _safeMint(agent, tokenId);

        emit CredentialIssued(tokenId, msg.sender, agent, policy.maxBudget, policy.expiry);
        emit Locked(tokenId); // ERC-5192: locked at mint
    }

    /// @notice Revoke a credential. Only the policy owner can call this.
    /// @param tokenId The credential to revoke.
    function revokeCredential(uint256 tokenId) external {
        AgentPolicy storage p = policies[tokenId];
        if (p.owner != msg.sender) revert OnlyPolicyOwner();
        if (!p.active) revert CredentialNotActive(tokenId);

        p.active = false;
        agentToToken[p.agent] = 0;

        emit CredentialRevoked(tokenId, p.agent);
    }

    // ─── View Functions ──────────────────────────────────────────────

    /// @notice Return the full policy for a credential.
    function getPolicy(uint256 tokenId) external view returns (AgentPolicy memory) {
        return policies[tokenId];
    }

    /// @notice Check whether a credential is currently valid (active + not expired).
    function isValid(uint256 tokenId) external view returns (bool) {
        AgentPolicy storage p = policies[tokenId];
        return p.active && block.timestamp < p.expiry;
    }

    /// @dev ERC-5192: all tokens are permanently locked.
    function locked(uint256 /* tokenId */) external pure returns (bool) {
        return true;
    }

    // ─── SBT Transfer Lock ──────────────────────────────────────────

    /// @dev Block all transfers — this is a Soul Bound Token.
    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override returns (address) {
        address from = _ownerOf(tokenId);
        // Allow minting (from == address(0)) but block all transfers
        if (from != address(0) && to != address(0)) {
            revert SoulBoundTransferBlocked();
        }
        return super._update(to, tokenId, auth);
    }

    // ─── ERC-165 ─────────────────────────────────────────────────────

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override
        returns (bool)
    {
        // ERC-5192 interface ID = 0xb45a3c0e
        return interfaceId == 0xb45a3c0e || super.supportsInterface(interfaceId);
    }
}
