// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./AgentCredential.sol";

/// @title ProofAgentRegistry — Public registry of authorized AI agents
/// @notice Allows external protocols to check whether an agent is registered
///         and what credential it holds, without needing to interact with the
///         full authorization flow.
contract ProofAgentRegistry {

    // ─── State ───────────────────────────────────────────────────────

    AgentCredential public immutable credential;

    /// @notice agent address → credential token ID (0 = not registered)
    mapping(address => uint256) public agentCredentials;

    /// @notice Total registered agents (metric for grants reporting)
    uint256 public totalRegistered;

    /// @notice Contract admin
    address public immutable admin;

    // ─── Events ──────────────────────────────────────────────────────

    event AgentRegistered(address indexed agent, uint256 indexed credentialId);
    event AgentDeregistered(address indexed agent, uint256 indexed credentialId);

    // ─── Errors ──────────────────────────────────────────────────────

    error AgentAlreadyRegistered(address agent);
    error AgentNotRegistered(address agent);
    error InvalidCredential(uint256 credentialId);
    error NotCredentialOwner();

    // ─── Constructor ─────────────────────────────────────────────────

    /// @param _credential Address of the AgentCredential SBT contract.
    constructor(address _credential) {
        credential = AgentCredential(_credential);
        admin = msg.sender;
    }

    // ─── Registration ────────────────────────────────────────────────

    /// @notice Register an agent in the public registry.
    /// @dev Can be called by the credential owner (human principal) or the agent itself.
    /// @param agent        The agent wallet address to register.
    /// @param credentialId The SBT credential token ID.
    function registerAgent(address agent, uint256 credentialId) external {
        if (agentCredentials[agent] != 0) revert AgentAlreadyRegistered(agent);
        if (!credential.isValid(credentialId)) revert InvalidCredential(credentialId);

        AgentCredential.AgentPolicy memory policy = credential.getPolicy(credentialId);

        // Only the policy owner or the agent itself can register
        if (msg.sender != policy.owner && msg.sender != agent) revert NotCredentialOwner();
        // Credential must be bound to this agent
        if (policy.agent != agent) revert InvalidCredential(credentialId);

        agentCredentials[agent] = credentialId;
        totalRegistered++;

        emit AgentRegistered(agent, credentialId);
    }

    /// @notice Remove an agent from the registry.
    /// @dev Can be called by the credential owner or the agent itself.
    function deregisterAgent(address agent) external {
        uint256 credentialId = agentCredentials[agent];
        if (credentialId == 0) revert AgentNotRegistered(agent);

        AgentCredential.AgentPolicy memory policy = credential.getPolicy(credentialId);

        // Only the policy owner or the agent itself can deregister
        if (msg.sender != policy.owner && msg.sender != agent) revert NotCredentialOwner();

        delete agentCredentials[agent];
        totalRegistered--;

        emit AgentDeregistered(agent, credentialId);
    }

    // ─── Public View Functions ───────────────────────────────────────

    /// @notice Check if an address is a registered agent with a valid credential.
    /// @param agent The address to check.
    /// @return True if registered AND credential is still valid (active + not expired).
    function isRegisteredAgent(address agent) external view returns (bool) {
        uint256 credentialId = agentCredentials[agent];
        if (credentialId == 0) return false;
        return credential.isValid(credentialId);
    }

    /// @notice Get the credential ID for a registered agent.
    /// @param agent The agent address.
    /// @return credentialId The SBT token ID (0 if not registered).
    function getAgentCredential(address agent) external view returns (uint256) {
        return agentCredentials[agent];
    }

    /// @notice Get the full policy details for a registered agent.
    /// @dev Convenience function that combines registry lookup + credential query.
    /// @param agent The agent address.
    /// @return policy The agent's authorization policy.
    function getAgentPolicy(
        address agent
    ) external view returns (AgentCredential.AgentPolicy memory policy) {
        uint256 credentialId = agentCredentials[agent];
        if (credentialId == 0) revert AgentNotRegistered(agent);
        return credential.getPolicy(credentialId);
    }
}
