# PROOFAGENT — Base Batches 2026 Application
# Startup Track
# proofagent.ch

---

## 1. Project Name
PROOFAGENT

## 2. One-Line Description
ZK Authorization Layer for Autonomous AI Agents — enabling agents to prove their permissions via zero-knowledge proofs without revealing their owner's identity, built natively for Base and x402.

## 3. Project Website
proofagent.ch

## 4. Project Category
Infrastructure / AI Agent Tooling / ZK Privacy

## 5. Team

**Founder:** Charly Grossrieder
**Entity:** Etienne-plus Sarl (CHE-204.174.717), Geneva, Switzerland
**Role:** Full-stack ZK + blockchain developer
**Background:**
- Built and deployed PRIVEX ZK verification system (Circom Groth16 circuits + Solidity contracts)
- Smart contracts live on 5 EVM chains (Base, Arbitrum, Linea, Polygon, BSC)
- Production stack: FastAPI + Next.js + Supabase + Vercel
- GitHub: https://github.com/Charlot74
- Twitter/X: @ProofAgent
- Farcaster: @proofagent
- Team size: 1 (solo founder, looking to expand post-grant)

## 6. Problem Statement

AI agents are transacting onchain at scale — Coinbase's x402 protocol alone has processed 50M+ machine-to-machine payments. But the agent economy has a critical infrastructure gap:

**Agents can own wallets. They cannot prove they are authorized to use them.**

When an AI agent initiates an x402 payment or interacts with a DeFi protocol, the counterparty has no cryptographic way to verify:
- Was this agent authorized by a legitimate human principal?
- Is the action within the agent's permitted scope (spending limits, allowed protocols)?
- Is the authorization still valid?

Current solutions either expose the owner's identity (breaking privacy and agent autonomy) or rely on centralized API keys (no onchain verifiability, single point of failure).

a16z calls this the "Know Your Agent" (KYA) problem — the number one missing primitive in the agent economy. PROOFAGENT solves it.

## 7. Solution

PROOFAGENT is a zero-knowledge authorization protocol that lets AI agents prove they have permission to act — without revealing who gave them permission or what else they can do.

**Core mechanism:**
1. Human owner mints an **Authorization SBT** (Soul Bound Token) on Base defining the agent's policy: spending limits, allowed protocols, time bounds, action types
2. When the agent needs to transact, it generates a **Groth16 ZK proof** proving: "I am authorized for this specific action, within my limits, and my credential is not revoked"
3. The counterparty (x402 endpoint, DeFi protocol, API) **verifies the proof onchain on Base** — one transaction, <$0.01 gas, ~200ms

**Key properties:**
- Zero knowledge of owner identity
- Granular policy enforcement (amount, protocol, time, action type)
- Non-transferable credentials (SBTs)
- Composable with any Base protocol
- Works with any agent framework (LangChain, AutoGPT, CrewAI)

## 8. What Have You Built So Far?

**Deployed and working:**
- ZK circuits in Circom 2.0 (Groth16) — validated on Ethereum Sepolia
- Smart contracts (Solidity 0.8.x) deployed on Base, Arbitrum, Linea, Polygon, BSC
- Soul Bound Token (ERC-5192) credential system
- Full backend (FastAPI Python) in production
- Frontend (Next.js 14) in production
- Infrastructure: Supabase + Vercel + Cloudflare

**Not yet built (what we need Base Batches for):**
- x402 protocol integration (AgentGateway contract)
- Builder SDK (TypeScript + Python)
- Multi-agent coordination proofs
- Developer documentation and testnet sandbox

## 9. Why Base?

Base is the natural home for PROOFAGENT because:

1. **x402 is our #1 integration.** Coinbase built the machine-to-machine payment protocol. We build the authorization layer on top of it. Together: authorized agent payments.

2. **Cost enables the use case.** ZK proof verification on Base costs <$0.01. Agents executing hundreds of transactions/hour need this cost structure.

3. **Coinbase agent infrastructure alignment.** CDP Wallets + x402 + PROOFAGENT = complete stack for authorized AI agent commerce. We complete the triangle.

4. **Builder community.** Base has the densest concentration of AI x crypto builders. Our SDK will be adopted fastest here.

## 10. What Would You Build During Base Batches?

**8-Week Plan:**

| Week | Deliverable |
|------|-------------|
| 1-2 | AgentGateway.sol: smart contract bridge between PROOFAGENT and x402 |
| 3-4 | proofagent-sdk v1 (TypeScript): npm package for agent builders |
| 5 | Integration with 2 live Base protocols (DeFi + payments) |
| 6 | Developer documentation + testnet sandbox with faucet |
| 7 | Builder workshop (virtual) + 5 pilot integrations |
| 8 | Demo Day preparation + metrics report |

**Demo Day deliverable:** Live demo of an AI agent making an x402 payment on Base, authorized by a PROOFAGENT ZK proof, with the owner's identity fully private.

## 11. Traction & Metrics

| Metric | Current | Target (Post-Batches) |
|--------|---------|----------------------|
| Chains deployed | 5 (Base, Arbitrum, Linea, Polygon, BSC) | 5+ |
| ZK circuit validated | Yes (Sepolia) | Base mainnet production |
| x402 integrations | 0 | 3+ |
| SDK downloads | 0 | 500+ |
| Builder integrations | 0 | 10+ |
| Authorized agent txns | 0 | 1,000+ |

## 12. Business Model

**Phase 1 (Current — Grant/Pre-revenue):**
Open-source protocol, free to use. Focus on adoption and ecosystem integration.

**Phase 2 (Post-traction):**
- Premium policy templates for enterprise agents
- Managed proof generation service (for agents that cannot run Circom locally)
- Authorization-as-a-Service API for non-crypto-native AI companies
- Protocol fees on high-volume M2M payment authorization (0.01-0.1% of transaction value)

**Revenue target:** Not the current focus. Building infrastructure for the agent economy first. Revenue follows adoption.

## 13. Competitive Landscape

| Approach | Weakness | PROOFAGENT Advantage |
|----------|----------|---------------------|
| API keys (centralized) | No onchain verifiability, single point of failure | Onchain ZK proofs, decentralized |
| OAuth for agents | Reveals owner identity, not privacy-preserving | Zero knowledge of owner |
| Multi-sig wallets | Requires human in the loop for every tx | Autonomous within policy bounds |
| Trusted execution environments (TEE) | Hardware dependency, not composable | Pure cryptographic, composable with any protocol |
| No authorization (raw wallet) | No constraints, no accountability | Granular policy enforcement |

**No one is building ZK authorization specifically for AI agents on Base.** We are the first mover.

## 14. What Do You Need Most from Base Batches?

1. **Coinbase x402 team introductions** — We need direct access to the x402 protocol team to build the tightest possible integration
2. **Coinbase Ventures visibility** — Our long-term vision requires funding beyond the grant; Base Batches is our path to the $50K investment
3. **Base builder community access** — Our SDK adoption depends on reaching the builders. Base Batches gives us the network.
4. **Technical mentorship** — Feedback on our ZK circuit design and smart contract architecture from the Base/Coinbase engineering team

## 15. Funding History

- **Self-funded** through Etienne-plus Sarl (Switzerland)
- No prior VC funding
- No prior grants received
- All development to date has been bootstrapped

## 16. Contact

**Charly Grossrieder**
Founder, PROOFAGENT
Etienne-plus Sarl
Geneva, Switzerland
Email: hello@proofagent.ch
Twitter/X: @ProofAgent
Farcaster: @proofagent
