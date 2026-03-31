# PROOFAGENT
## ZK Authorization Layer for Autonomous AI Agents
## proofagent.ch

---

### THE PROBLEM

AI agents are executing 50M+ onchain transactions via Coinbase's x402 protocol. But agents can own wallets without being able to prove they are authorized to use them. Current solutions leak the owner's identity or rely on centralized API keys. a16z identifies this as the "Know Your Agent" (KYA) gap — the #1 missing primitive in the agent economy.

### THE SOLUTION

PROOFAGENT lets AI agents prove their permissions via zero-knowledge proofs — without revealing their owner's identity, the full scope of their authorization, or any private data.

```
Owner defines policy (SBT) -> Agent generates ZK proof -> Protocol verifies onchain (<$0.01)
```

**Three properties in one proof:**
1. The agent IS authorized by a real principal
2. The action IS within policy bounds (amount, protocol, time)
3. The credential IS NOT revoked

### WHY NOW

- Brian Armstrong: "AI agents will surpass humans in transaction volume via crypto wallets"
- a16z: "Know Your Agent (KYA) is the missing primitive"
- Citrini report: Visa -4.4%, Mastercard -6.3% — traditional rails cannot serve agents
- x402 has 50M+ transactions but zero authorization layer

### TECH STACK (DEPLOYED)

| Component | Technology | Status |
|-----------|-----------|--------|
| ZK Circuits | Circom Groth16 | Validated (Sepolia) |
| Smart Contracts | Solidity | Deployed on 5 chains incl. Base |
| Credentials | Soul Bound Tokens (ERC-5192) | Deployed |
| Backend/Frontend | FastAPI + Next.js | Production |

### TRACTION

- Live on Base, Arbitrum, Linea, Polygon, BSC
- ZK proof verification: ~230K gas (<$0.01 on Base)
- Proof generation: ~250ms (browser), ~100ms (server)
- Open-source (MIT license)

### BUSINESS MODEL

Phase 1: Open-source protocol, free adoption
Phase 2: Premium policies, managed proof service, Auth-as-a-Service API

### ASK

**Base Builder Grant:** 5 ETH for x402 integration + Builder SDK
**Base Batches:** 8-week program to ship x402 integration and onboard 10+ builder teams

### 3-MONTH ROADMAP

Month 1: x402 AgentGateway contract on Base
Month 2: TypeScript + Python SDK on npm/pypi
Month 3: 10+ builder integrations, testnet sandbox, documentation

### TEAM

**Charly Grossrieder** — Founder & Lead Developer
Etienne-plus Sarl (CHE-204.174.717), Geneva, Switzerland
Full-stack ZK + blockchain developer. Built PRIVEX ZK verification system.

### CONTACT

- Web: proofagent.ch
- GitHub: https://github.com/Charlot74/proofagent
- Twitter: https://twitter.com/ProofAgent
- Farcaster: https://warpcast.com/proofagent
- Email: hello@proofagent.ch
