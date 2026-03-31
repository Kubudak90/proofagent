# PROOFAGENT — Base Builder Grant Application
# ZK Authorization Layer for Autonomous AI Agents
# Submitted: April 2026
# proofagent.ch

---

## Section 1: Project Overview

**Project Name:** PROOFAGENT

**One-liner:** ZK Authorization Layer for Autonomous AI Agents on Base

**Website:** proofagent.ch

**GitHub:** https://github.com/Charlot74/proofagent

**Deployed on Ethereum Sepolia:** Yes — AgentCredential: `0x48BED46b86A5B2Df444EAc462a04E47AC892eC6D` | ProofVerifier: `0x583b00aE28dFB28ab4Bf4b0c79F212C85C4F70fD` | AgentGateway: `0x704E4D911f9a56C2b296C9D13718eA53A5E6da02` | ProofAgentRegistry: `0xE31722f304A2b3Bc2B65a5bbC32B4c6E119a7f2f` — Base mainnet deployment scheduled as Milestone 1 upon grant approval.

### The Problem

AI agents are about to surpass humans in onchain transaction volume. Coinbase's x402 protocol and Agentic Wallets have already processed 50M+ machine-to-machine transactions. But there is a critical missing primitive: **agents can own wallets but cannot prove they are authorized to use them.**

Today, when an AI agent initiates a payment via x402 or calls a third-party API, the receiving protocol has no way to verify:
- Is this agent authorized by a real human principal?
- What are the boundaries of its permissions (spending limits, allowed actions)?
- Is the authorization still valid and not revoked?

The only current options leak the owner's identity (defeating the purpose of agent autonomy) or rely on centralized API keys (single point of failure, no onchain verifiability). This is the "Know Your Agent" (KYA) gap that a16z identified as the missing piece of the agent economy.

### The Solution

PROOFAGENT is a ZK authorization layer that lets AI agents cryptographically prove their permissions without revealing their owner's identity or the full scope of their authorization. Built natively for Base and the x402 payment protocol.

**How it works:**
1. A human owner defines an **Authorization Policy** (spending limits, allowed protocols, time bounds, action types) and commits it onchain as a Soul Bound Token (SBT) credential
2. When an agent needs to act, PROOFAGENT generates a **ZK proof** (Groth16 via Circom) that proves: "I am authorized to spend up to X USDC on protocol Y before date Z" — without revealing the owner, the full policy, or other permissions
3. The receiving protocol (x402 endpoint, DeFi contract, API gateway) **verifies the proof onchain** in a single transaction on Base, with gas costs under $0.01

**What makes PROOFAGENT unique:**
- **Privacy-preserving:** Zero knowledge of owner identity — the agent proves authorization, not identity
- **Granular:** Policies can specify spending limits, protocol whitelists, time windows, and action types
- **Onchain-native:** Proofs are verified by smart contracts on Base, composable with any protocol
- **Non-transferable:** SBT-based credentials cannot be moved to unauthorized agents
- **Interoperable:** Works across any agent framework (LangChain, AutoGPT, CrewAI) and any payment protocol (x402, USDC, any ERC-20)

---

## Section 2: Alignment with Base Ecosystem

### Why Base?

PROOFAGENT is built for Base because Base is where the AI agent economy lives:

1. **x402 is our primary integration target.** Coinbase's machine-to-machine payment protocol needs an authorization layer. PROOFAGENT is that layer. When an x402 payment is initiated, the receiving server can require a PROOFAGENT ZK proof before processing — adding cryptographic authorization without adding friction.

2. **Agentic Wallets need KYA.** Brian Armstrong stated that AI agents will soon execute more transactions than humans via crypto wallets. Every one of those transactions needs authorization verification. PROOFAGENT provides it.

3. **Base's cost structure enables our use case.** ZK proof verification on Base costs <$0.01 per transaction. This makes it economically viable for high-frequency M2M payments where agents might execute hundreds of transactions per hour.

4. **Base developer ecosystem.** Base has the most active builder community for AI x crypto projects. PROOFAGENT positions itself as infrastructure for these builders.

### Ecosystem Value

PROOFAGENT adds value to Base by:
- **Increasing Base transaction volume:** Every agent authorization = one Base transaction
- **Enabling new use cases:** Protocols on Base can now accept agent transactions with cryptographic guarantees, unlocking M2M commerce
- **Attracting AI agent builders:** PROOFAGENT's SDK makes Base the easiest chain to build authorized AI agents on
- **Strengthening the x402 stack:** PROOFAGENT completes the Coinbase agent infrastructure (CDP Wallet + x402 + PROOFAGENT authorization)

---

## Section 3: Technical Architecture

### Stack (Deployed)

| Component | Technology | Status |
|-----------|-----------|--------|
| ZK Circuits | Circom 2.0 (Groth16) | Validated on Sepolia |
| Smart Contracts | Solidity 0.8.x | Deployed on Base, Arbitrum, Linea, Polygon, BSC |
| Credential System | ERC-5192 Soul Bound Tokens | Deployed |
| Backend | FastAPI (Python) | Production |
| Frontend | Next.js 14 | Production |
| Database | Supabase (PostgreSQL) | Production |
| Hosting | Vercel + Cloudflare | Production |

### Authorization Flow

```
Human Owner                    AI Agent                     Protocol (x402)
     |                            |                              |
     |-- Define Policy ---------> |                              |
     |   (SBT minted on Base)     |                              |
     |                            |                              |
     |                            |-- Request Action ----------> |
     |                            |   (x402 payment request)     |
     |                            |                              |
     |                            |<- Require ZK Auth Proof ---- |
     |                            |                              |
     |                            |-- Generate ZK Proof -------> |
     |                            |   (proves: authorized,       |
     |                            |    within limits,            |
     |                            |    not expired)              |
     |                            |                              |
     |                            |   Verify Proof Onchain       |
     |                            |   (Base, <$0.01 gas)         |
     |                            |                              |
     |                            |<- Action Executed ---------- |
     |                            |   (payment processed)        |
```

### ZK Circuit Design

The core PROOFAGENT circuit proves three claims simultaneously:
1. **Authorization:** The agent holds a valid SBT credential issued by an authorized principal
2. **Policy Compliance:** The requested action falls within the policy bounds (amount <= limit, protocol in whitelist, time < expiry)
3. **Non-revocation:** The credential has not been revoked (checked against onchain nullifier tree)

All three claims are proven in a single Groth16 proof (~250ms generation, ~200KB proof size, <$0.01 verification on Base).

### Smart Contract Architecture

```
ProofAgentVerifier.sol    -- Verifies Groth16 proofs onchain
PolicyRegistry.sol        -- Stores authorization policies as SBTs
NullifierTree.sol         -- Tracks revocations (Merkle tree)
AgentGateway.sol          -- Entry point for x402 integration
```

---

## Section 4: Team

### Founder

**Charly Grossrieder** — Founder & Lead Developer
- Entity: Etienne-plus Sarl (CHE-204.174.717), Geneva, Switzerland
- Background: Full-stack blockchain developer with ZK proof expertise
- Built and deployed PRIVEX ZK Age verification system (Circom + Solidity)
- Deployed smart contracts across 5 EVM chains
- Active builder in Base and Arbitrum ecosystems

- GitHub: https://github.com/Charlot74
- Twitter/X: @ProofAgent
- Farcaster: @proofagent
- Email: hello@proofagent.ch

---

## Section 5: Roadmap & Milestones

### What we have built (Before Grant)

- ZK circuits in Circom (Groth16) — validated on Sepolia testnet
- Smart contracts deployed on Base, Arbitrum, Linea, Polygon, BSC
- SBT credential system (ERC-5192)
- Full backend (FastAPI) and frontend (Next.js)
- Production infrastructure (Supabase, Vercel, Cloudflare)

### What the grant funds (3-Month Roadmap)

**Month 1: x402 Integration**
- Build AgentGateway.sol — smart contract bridge between PROOFAGENT and x402 protocol
- Implement x402 payment authorization flow (agent requests payment -> PROOFAGENT proof required -> payment processed)
- Deploy on Base mainnet
- KPI: First authorized M2M payment via x402 + PROOFAGENT on Base

**Month 2: Builder SDK**
- Release proofagent-sdk (TypeScript/Python) for AI agent developers
- Integration guides for LangChain, AutoGPT, CrewAI
- Documentation and tutorials on proofagent.ch/docs
- KPI: SDK published on npm/pypi, 3+ builder integrations

**Month 3: Ecosystem Growth**
- Launch PROOFAGENT testnet for builders (faucet + sandbox)
- Host a Base builder workshop (virtual)
- Publish technical blog posts on architecture and use cases
- Submit to Base ecosystem directory
- KPI: 10+ projects testing PROOFAGENT, 100+ developer signups

### Post-Grant Vision (6-12 months)

- Multi-chain authorization (single proof works across Base, Arbitrum, Polygon)
- Advanced policy types (rate limiting, multi-sig agent coordination, delegation chains)
- Integration with Coinbase CDP (Coinbase Developer Platform) as native authorization module
- Seek Base Batches investment ($50K) for scaling

---

## Section 6: Budget

**Total Requested:** 5 ETH (~$10,000-$15,000 at current rates)

| Category | Allocation | Details |
|----------|-----------|---------|
| Smart Contract Development | 40% | x402 integration contracts, auditing, gas for deployment |
| SDK Development | 30% | TypeScript + Python SDK, documentation, testing |
| Infrastructure | 15% | RPC nodes, proof generation servers, hosting |
| Community & Growth | 15% | Builder workshops, documentation, ecosystem outreach |

**Note:** All grant-funded work will be open-source (MIT license) and deployed on Base mainnet.

---

## Section 7: Why Now?

The convergence of three trends makes PROOFAGENT urgently needed:

1. **Agent transaction volume is exploding.** x402 has processed 50M+ transactions. Brian Armstrong projects agents will surpass humans in transaction volume. Every transaction needs authorization.

2. **The KYA gap is recognized.** a16z explicitly identifies "Know Your Agent" as the missing primitive. Non-human identities outnumber human employees 96-to-1 in financial services. The market is looking for this solution.

3. **Regulatory pressure is building.** The Citrini "2028 Global Intelligence Crisis" report caused Visa to drop 4.4% and Mastercard 6.3%. Traditional payment rails cannot adapt to agent commerce. Crypto + ZK authorization is the only scalable path.

**PROOFAGENT is not speculative infrastructure — it is the authorization layer that the existing agent economy already needs.**

---

## Section 8: Links & Resources

| Resource | URL |
|----------|-----|
| Website | proofagent.ch |
| GitHub | https://github.com/Charlot74/proofagent |
| Demo | proofagent.ch/demo [COMING SOON] |
| Technical Docs | proofagent.ch/docs [COMING SOON] |
| Founder Twitter/X | https://twitter.com/ProofAgent |
| Founder Farcaster | https://warpcast.com/proofagent |
| Sepolia Deployment | [AgentCredential](https://sepolia.etherscan.io/address/0x48BED46b86A5B2Df444EAc462a04E47AC892eC6D) · [ProofVerifier](https://sepolia.etherscan.io/address/0x583b00aE28dFB28ab4Bf4b0c79F212C85C4F70fD) · [AgentGateway](https://sepolia.etherscan.io/address/0x704E4D911f9a56C2b296C9D13718eA53A5E6da02) · [Registry](https://sepolia.etherscan.io/address/0xE31722f304A2b3Bc2B65a5bbC32B4c6E119a7f2f) |
| Builder Score | builderscore.xyz [REGISTER_FIRST] |

---

## Contact

**Charly Grossrieder**
Etienne-plus Sarl
Geneva, Switzerland
Email: hello@proofagent.ch
Twitter/X: @ProofAgent
Farcaster: @proofagent
