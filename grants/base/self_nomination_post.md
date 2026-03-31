# PROOFAGENT — Self-Nomination Posts
# For Farcaster & Twitter/X

---

## VERSION 1: Farcaster Post (Builder Grant Self-Nomination)
### Target: /base channel + tag @base @jessepollak

```
Building PROOFAGENT on Base — the ZK authorization layer for AI agents.

The problem: x402 and Agentic Wallets let agents transact onchain. But no agent can prove it's authorized to use its wallet.

PROOFAGENT fixes this. One ZK proof = "I'm authorized for this action" — without revealing the owner's identity.

How it works:
1. Owner mints an Authorization SBT on Base (spending limits, allowed protocols, time bounds)
2. Agent generates a Groth16 ZK proof in ~250ms
3. x402 endpoint verifies onchain for <$0.01

Already deployed: Circom circuits validated, contracts live on Base + 4 more chains.

Now building: x402 integration + TypeScript SDK for agent builders.

This is the "Know Your Agent" primitive that @a]16z says is missing. We're building it on Base.

proofagent.ch

@grants.base.eth self-nominating for Builder Grant
```

---

## VERSION 2: Twitter/X Thread (Technical + Narrative)

### Tweet 1 (Hook)
```
AI agents will soon make more transactions than humans.

They can own crypto wallets. But they can't prove they're authorized to use them.

We're fixing this with zero-knowledge proofs.

Introducing PROOFAGENT — the ZK authorization layer for AI agents on @base.

Thread:
```

### Tweet 2 (Problem)
```
The problem:

When an AI agent pays via x402 or calls a DeFi protocol, the counterparty has NO way to verify:

- Is this agent authorized?
- What are its spending limits?
- Is the authorization still valid?

Current options: leak the owner's identity, or use centralized API keys.

Neither works at scale.
```

### Tweet 3 (Solution)
```
PROOFAGENT: one ZK proof answers all three questions.

"I am authorized to spend up to X USDC on protocol Y before date Z"

Zero knowledge of:
- Who the owner is
- What else the agent can do
- Any private data

Verified onchain on Base for <$0.01.
```

### Tweet 4 (How it works)
```
How it works:

1. Owner mints an Authorization SBT (Soul Bound Token) on Base
   -> Defines: spending limits, allowed protocols, time bounds

2. Agent generates a Groth16 ZK proof (~250ms)
   -> Proves: authorized + within limits + not revoked

3. Protocol verifies onchain (~230K gas)
   -> If valid: action proceeds. If not: rejected.
```

### Tweet 5 (Why now)
```
Why now:

- @brian_armstrong: agents will surpass humans in txn volume via crypto wallets
- @a16z: "Know Your Agent" is THE missing primitive
- x402 has 50M+ txns but zero authorization layer
- Citrini report: Visa -4.4%, Mastercard -6.3% — traditional rails can't serve agents

The agent economy needs KYA. We're building it.
```

### Tweet 6 (Traction)
```
What we've shipped:

- ZK circuits (Circom Groth16) — validated on Sepolia
- Smart contracts on Base, Arbitrum, Linea, Polygon, BSC
- Soul Bound Token credentials (ERC-5192)
- Full stack: FastAPI + Next.js + Supabase

Now building: x402 integration + Builder SDK

All open-source. MIT license.
```

### Tweet 7 (CTA)
```
PROOFAGENT = the authorization layer that completes the Coinbase agent stack:

CDP Wallet (identity) + x402 (payments) + PROOFAGENT (authorization)

If you're building AI agents on @base — we're building for you.

proofagent.ch

@jessepollak @base self-nominating for Base Builder Grant.
```

---

## VERSION 3: Short Farcaster Post (Community Engagement)

```
Hot take: every AI agent transaction without ZK authorization is a security vulnerability.

Agents can't prove they're authorized. Protocols can't verify them. Owners can't limit them.

We built PROOFAGENT to fix this on Base.

One ZK proof. Full authorization. Zero identity leakage.

proofagent.ch
```

---

## VERSION 4: Builder Grant Self-Nomination Email
### To: grants@base.eth (or self-nomination form)

```
Subject: PROOFAGENT — ZK Authorization for AI Agents on Base (Builder Grant Nomination)

Hi Base Grants team,

I'm Charly Grossrieder, founder of PROOFAGENT (proofagent.ch) — the ZK authorization layer for autonomous AI agents, built on Base.

The problem we solve: AI agents can own wallets (CDP, x402) but cannot cryptographically prove they are authorized to use them. PROOFAGENT lets agents generate ZK proofs that verify their authorization without revealing their owner's identity.

What we've shipped:
- ZK circuits (Circom Groth16) validated on Sepolia
- Smart contracts deployed on Base + 4 additional chains
- Soul Bound Token (ERC-5192) credential system
- Full production stack (FastAPI + Next.js + Supabase)

What we're building next:
- x402 protocol integration (AgentGateway.sol)
- TypeScript + Python SDK for agent builders
- Developer documentation and testnet sandbox

We're requesting a Builder Grant (1-5 ETH) to fund the x402 integration and SDK development — the two pieces that make PROOFAGENT directly useful for Base builders today.

This is the "Know Your Agent" primitive that a16z identified as missing. We're building it natively on Base.

Happy to share a demo or technical walkthrough.

Best,
Charly Grossrieder
Etienne-plus Sarl | Geneva, Switzerland
proofagent.ch
```

---

## POSTING STRATEGY

| Day | Platform | Content | Target Audience |
|-----|----------|---------|-----------------|
| Day 1 | Farcaster /base | Version 1 (self-nomination) | Base builders + grants team |
| Day 1 | Twitter/X | Version 2 (thread) | Crypto AI community |
| Day 2 | Farcaster | Version 3 (short engagement) | General crypto community |
| Day 2 | Email/Form | Version 4 (formal nomination) | Base grants team |
| Day 3+ | Farcaster | Reply to relevant Base/AI agent discussions | Organic engagement |

**Tags to use consistently:**
- @base @jessepollak @grants.base.eth @coinbase @brian_armstrong
- #BuildOnBase #ZK #AIAgents #x402 #KnowYourAgent
