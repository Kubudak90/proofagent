# PROOFAGENT — Technical Architecture
# ZK Authorization Layer for Autonomous AI Agents

---

## 1. System Overview

PROOFAGENT is a zero-knowledge authorization protocol enabling AI agents to cryptographically prove they are authorized to perform specific actions without revealing their owner's identity or full permission scope.

```
+------------------------------------------------------------------+
|                     PROOFAGENT ARCHITECTURE                       |
+------------------------------------------------------------------+
|                                                                    |
|  HUMAN LAYER           AGENT LAYER           PROTOCOL LAYER       |
|  +-----------+         +------------+        +----------------+   |
|  |  Owner    |         |  AI Agent  |        | x402 / DeFi /  |   |
|  |  (hidden) |         |  (any      |        | API Gateway    |   |
|  |           |         |   framework)|       |                |   |
|  +-----+-----+        +------+------+       +-------+--------+   |
|        |                      |                      |            |
|        | 1. Define            | 3. Generate          | 4. Verify  |
|        |    Policy            |    ZK Proof          |    Proof   |
|        v                      v                      v            |
|  +----------------------------------------------------------+    |
|  |              PROOFAGENT PROTOCOL (Base L2)                |    |
|  |                                                            |    |
|  |  +----------------+  +----------------+  +--------------+ |    |
|  |  | PolicyRegistry |  | ProofAgent     |  | Nullifier    | |    |
|  |  | .sol           |  | Verifier.sol   |  | Tree.sol     | |    |
|  |  | (SBT ERC-5192) |  | (Groth16)      |  | (Revocation) | |    |
|  |  +----------------+  +----------------+  +--------------+ |    |
|  |                                                            |    |
|  |  +------------------------------------------------------+ |    |
|  |  |              AgentGateway.sol                         | |    |
|  |  |  (x402 integration + authorization middleware)        | |    |
|  |  +------------------------------------------------------+ |    |
|  +----------------------------------------------------------+    |
|                                                                    |
+------------------------------------------------------------------+
```

---

## 2. Smart Contract Architecture

### 2.1 PolicyRegistry.sol

**Purpose:** Stores authorization policies as Soul Bound Tokens (ERC-5192).

```solidity
// Core data structure
struct AuthorizationPolicy {
    address agent;           // Agent wallet address
    bytes32 policyHash;      // Hash of full policy (stored off-chain)
    uint256 spendingLimit;   // Max spending per period (in wei)
    uint256 periodDuration;  // Period length in seconds
    uint256 expiresAt;       // Policy expiration timestamp
    bytes32 protocolWhitelist; // Merkle root of allowed protocol addresses
    bytes32 actionTypeMask;  // Bitmap of allowed action types
    bool isActive;           // Can be deactivated by owner
}

// Key functions
function mintPolicy(address agent, AuthorizationPolicy calldata policy) external returns (uint256 tokenId);
function revokePolicy(uint256 tokenId) external; // Only owner
function isPolicyActive(uint256 tokenId) external view returns (bool);
function getPolicyHash(uint256 tokenId) external view returns (bytes32);
```

**Key design decisions:**
- Policies are SBTs (non-transferable) — an agent cannot delegate its authorization
- Only the policy hash is stored onchain; full policy details are off-chain (privacy)
- Owner can revoke at any time via `revokePolicy()`
- Gas cost: ~120K gas for mint, ~30K gas for revoke

### 2.2 ProofAgentVerifier.sol

**Purpose:** Verifies Groth16 ZK proofs that an agent is authorized for a specific action.

```solidity
// Proof verification
function verifyAuthorization(
    uint256[2] calldata _pA,       // Proof point A
    uint256[2][2] calldata _pB,    // Proof point B
    uint256[2] calldata _pC,       // Proof point C
    uint256[7] calldata _pubSignals // Public signals
) external view returns (bool);

// Public signals layout:
// [0] = policyTokenId (which SBT credential)
// [1] = actionHash (hash of the requested action)
// [2] = amountCommitment (committed spending amount)
// [3] = protocolAddress (target protocol)
// [4] = timestamp (current time)
// [5] = nullifier (prevents double-use)
// [6] = merkleRoot (nullifier tree root)
```

**Gas cost:** ~230K gas for Groth16 verification on Base (~$0.005)

### 2.3 NullifierTree.sol

**Purpose:** Tracks revoked credentials and spent authorizations using a Merkle tree.

```solidity
// Sparse Merkle Tree for nullifiers
uint256 public constant TREE_DEPTH = 20; // Supports 2^20 = 1M+ entries

function insertNullifier(bytes32 nullifier) external;
function isNullified(bytes32 nullifier) external view returns (bool);
function getRoot() external view returns (bytes32);
```

**Design:** Incremental Merkle tree pattern (same as used in Tornado Cash and Semaphore). Allows efficient insertion and membership proofs.

### 2.4 AgentGateway.sol

**Purpose:** Integration middleware for x402 protocol and other Base protocols.

```solidity
// x402 integration
function authorizePayment(
    address agent,
    address recipient,
    uint256 amount,
    address token,          // USDC, ETH, etc.
    bytes calldata zkProof  // PROOFAGENT proof
) external returns (bool authorized);

// Generic authorization for any protocol
function authorizeAction(
    address agent,
    bytes32 actionHash,
    bytes calldata zkProof
) external returns (bool authorized);

// Batch authorization (multiple actions in one tx)
function authorizeBatch(
    address agent,
    bytes32[] calldata actionHashes,
    bytes[] calldata zkProofs
) external returns (bool[] memory results);
```

---

## 3. ZK Circuit Design (Circom)

### 3.1 Core Authorization Circuit

```
Circuit: ProofAgentAuthorization
Proving system: Groth16
Curve: BN254
Constraint count: ~15,000
Proof generation time: ~250ms (browser), ~100ms (server)
Proof size: ~200 bytes (compressed)
```

**Circuit logic (simplified):**

```
template ProofAgentAuthorization() {
    // Private inputs (known only to agent)
    signal private input ownerSecret;      // Owner's secret key
    signal private input policyDetails;    // Full policy JSON hash
    signal private input pathElements[20]; // Merkle proof for non-revocation
    signal private input pathIndices[20];  // Merkle path indices

    // Public inputs (visible to verifier)
    signal input policyTokenId;
    signal input actionHash;
    signal input amountCommitment;
    signal input protocolAddress;
    signal input timestamp;
    signal input nullifier;
    signal input merkleRoot;

    // Constraint 1: AUTHORIZATION
    // Prove that ownerSecret corresponds to the SBT holder
    // Hash(ownerSecret) == registeredOwnerHash
    component authCheck = Poseidon(1);
    authCheck.inputs[0] <== ownerSecret;
    // authCheck.out must match stored owner commitment

    // Constraint 2: POLICY COMPLIANCE
    // Prove that the action is within policy bounds
    // amount <= spendingLimit
    // protocolAddress is in whitelist
    // timestamp < expiresAt
    component policyCheck = PolicyCompliance();
    policyCheck.amount <== amountCommitment;
    policyCheck.protocol <== protocolAddress;
    policyCheck.time <== timestamp;
    // policyCheck.valid must be 1

    // Constraint 3: NON-REVOCATION
    // Prove that the credential is not in the nullifier tree
    component merkleProof = MerkleTreeChecker(20);
    merkleProof.leaf <== nullifier;
    merkleProof.root <== merkleRoot;
    for (var i = 0; i < 20; i++) {
        merkleProof.pathElements[i] <== pathElements[i];
        merkleProof.pathIndices[i] <== pathIndices[i];
    }
    // merkleProof.valid must be 1
}
```

### 3.2 Proof Generation Flow

```
1. Agent receives action request (e.g., x402 payment for 50 USDC)
2. Agent SDK fetches its policy from PolicyRegistry (via RPC)
3. Agent SDK fetches current nullifier tree root
4. Agent SDK generates witness:
   - Private: owner secret, full policy, Merkle path
   - Public: policy ID, action hash, amount, protocol, time, nullifier, root
5. Agent SDK runs Groth16 prover (WASM in browser or native on server)
6. Proof + public signals sent to AgentGateway.sol
7. Smart contract verifies in ~230K gas
8. If valid: action proceeds. If invalid: action rejected.
```

---

## 4. SDK Architecture

### 4.1 TypeScript SDK (proofagent-sdk)

```typescript
// Installation
// npm install @proofagent/sdk

import { ProofAgent } from '@proofagent/sdk';

// Initialize
const agent = new ProofAgent({
  chainId: 8453, // Base
  rpcUrl: 'https://mainnet.base.org',
  policyTokenId: 42,
  ownerSecret: process.env.OWNER_SECRET, // Never exposed
});

// Authorize a payment
const proof = await agent.authorizePayment({
  recipient: '0x...',
  amount: '50000000', // 50 USDC (6 decimals)
  token: '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913', // USDC on Base
});

// Send authorized x402 payment
const tx = await agent.executeAuthorized(proof);
console.log(`Payment authorized: ${tx.hash}`);

// Check remaining authorization
const remaining = await agent.getRemainingBudget();
console.log(`Remaining: ${remaining.amount} USDC`);
```

### 4.2 Python SDK (proofagent-py)

```python
# pip install proofagent

from proofagent import ProofAgent

agent = ProofAgent(
    chain_id=8453,  # Base
    policy_token_id=42,
    owner_secret=os.environ["OWNER_SECRET"],
)

# Authorize and execute
proof = agent.authorize_payment(
    recipient="0x...",
    amount=50_000_000,  # 50 USDC
    token="0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",
)

tx = agent.execute(proof)
```

### 4.3 Agent Framework Integrations

**LangChain:**
```python
from proofagent.integrations import LangChainAuthorizer

# Add PROOFAGENT as a LangChain tool
tools = [
    LangChainAuthorizer(policy_token_id=42),
    # ... other tools
]
agent = initialize_agent(tools, llm)
# Agent now auto-authorizes onchain actions via ZK proofs
```

**CrewAI / AutoGPT:** Similar integration pattern — PROOFAGENT becomes an authorization middleware that wraps any onchain action tool.

---

## 5. Security Model

### 5.1 Trust Assumptions

| Component | Trust Level | Justification |
|-----------|------------|---------------|
| ZK Circuit (Circom) | Trustless | Mathematically sound (Groth16 security) |
| Smart Contracts | Trustless | Onchain, auditable, deterministic |
| Agent Wallet | Trust agent operator | Agent holds private key |
| Owner Secret | Trust owner | Secret never leaves owner's device |
| Base L2 | Trust Base sequencer | Standard L2 trust model |
| Proof Generation | Trustless | Can be verified independently |

### 5.2 Attack Vectors & Mitigations

| Attack | Mitigation |
|--------|-----------|
| Stolen agent wallet | Owner revokes SBT via PolicyRegistry (instant) |
| Forged ZK proof | Cryptographically impossible (Groth16 soundness) |
| Replay attack | Nullifier prevents double-use of proofs |
| Policy tampering | Policy hash stored onchain, any change invalidates proofs |
| Owner key compromise | Multi-sig option for policy management |
| Front-running | Standard MEV protections (private mempool on Base) |

---

## 6. Deployment Addresses

Addresses will be populated after deployment — see deployments/base_mainnet_addresses.json

### Base Mainnet (chainId: 8453)
| Contract | Address |
|----------|---------|
| AgentCredential | Pending — Milestone 1 upon grant approval |
| ProofVerifier | Pending — Milestone 1 upon grant approval |
| AgentGateway | Pending — Milestone 1 upon grant approval |
| ProofAgentRegistry | Pending — Milestone 1 upon grant approval |

### Ethereum Sepolia Testnet (chainId: 11155111) — LIVE ✅
| Contract | Address |
|----------|---------|
| AgentCredential | [`0x48BED46b86A5B2Df444EAc462a04E47AC892eC6D`](https://sepolia.etherscan.io/address/0x48BED46b86A5B2Df444EAc462a04E47AC892eC6D) |
| ProofVerifier | [`0x583b00aE28dFB28ab4Bf4b0c79F212C85C4F70fD`](https://sepolia.etherscan.io/address/0x583b00aE28dFB28ab4Bf4b0c79F212C85C4F70fD) |
| AgentGateway | [`0x704E4D911f9a56C2b296C9D13718eA53A5E6da02`](https://sepolia.etherscan.io/address/0x704E4D911f9a56C2b296C9D13718eA53A5E6da02) |
| ProofAgentRegistry | [`0xE31722f304A2b3Bc2B65a5bbC32B4c6E119a7f2f`](https://sepolia.etherscan.io/address/0xE31722f304A2b3Bc2B65a5bbC32B4c6E119a7f2f) |

### Other Chains (PRIVEX legacy deployment)
- Arbitrum One: existing PRIVEX contracts
- Polygon PoS: existing PRIVEX contracts
- Linea: existing PRIVEX contracts
- BSC: existing PRIVEX contracts

---

## 7. Performance Benchmarks

| Metric | Value | Notes |
|--------|-------|-------|
| Proof generation (browser WASM) | ~250ms | Groth16, BN254 |
| Proof generation (server native) | ~100ms | Groth16, BN254 |
| Proof size | ~200 bytes | Compressed |
| Onchain verification gas | ~230K gas | Base L2 |
| Verification cost (Base) | <$0.01 | At current gas prices |
| Circuit constraint count | ~15,000 | Efficient for mobile/browser |
| SBT mint gas | ~120K gas | One-time per policy |
| Policy revocation gas | ~30K gas | Instant effect |
| Throughput | ~100 proofs/sec | Per agent, server-side |
