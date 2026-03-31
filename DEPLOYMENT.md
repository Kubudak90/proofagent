# PROOFAGENT — Deployment Guide

## Prerequisites

1. **Node.js** v18+ installed
2. **ETH on Base mainnet** for gas (~0.005 ETH sufficient for full deployment)
3. **Basescan API key** (optional, for contract verification) — get one at https://basescan.org/myapikey
4. **Private key** of the deployer wallet

## Step-by-Step Deployment

### 1. Install dependencies

```bash
cd C:\Users\Charlot\proofagent
npm install
```

### 2. Configure environment

```bash
cp .env.example .env
```

Edit `.env` and fill in:
- `PRIVATE_KEY` — your deployer wallet private key (with 0x prefix)
- `BASESCAN_API_KEY` — your Basescan API key (optional, for verification)

### 3. Compile contracts

```bash
npm run compile
```

Expected output: 4 contracts compiled successfully.

### 4. Deploy to Base Sepolia (testnet first)

```bash
npm run deploy:base-sepolia
```

This deploys all 4 contracts to Base Sepolia testnet. Verify everything works before mainnet.

### 5. Deploy to Base Mainnet

```bash
npm run deploy:base
```

The script will:
1. Deploy AgentCredential (SBT)
2. Deploy ProofVerifier (Groth16)
3. Deploy AgentGateway (x402 integration) — linked to contracts 1+2
4. Deploy ProofAgentRegistry — linked to contract 1
5. Save all addresses to `deployments/base_mainnet_addresses.json`
6. Optionally verify on Basescan (if API key is set)

### 6. Verify contracts on Basescan (if not auto-verified)

```bash
npx hardhat verify --network base <AgentCredential_ADDRESS>
npx hardhat verify --network base <ProofVerifier_ADDRESS>
npx hardhat verify --network base <AgentGateway_ADDRESS> <AgentCredential_ADDRESS> <ProofVerifier_ADDRESS>
npx hardhat verify --network base <ProofAgentRegistry_ADDRESS> <AgentCredential_ADDRESS>
```

## Gas Estimates

| Contract | Estimated Gas | Cost at 0.01 gwei base fee |
|----------|-------------|---------------------------|
| AgentCredential | ~1,500,000 | ~$0.001 |
| ProofVerifier | ~800,000 | ~$0.0005 |
| AgentGateway | ~1,200,000 | ~$0.0008 |
| ProofAgentRegistry | ~600,000 | ~$0.0004 |
| **Total** | **~4,100,000** | **~$0.003** |

Base L2 gas is extremely cheap. Total deployment cost should be well under $0.01.

## After Deployment

### Update grant documents with real addresses

Once deployed, open `deployments/base_mainnet_addresses.json` and copy the addresses into:

1. `grants/base/builder_grant_application.md` — Section 8 Links table
2. `grants/base/base_batches_application.md` — Section 8 traction
3. `grants/base/technical_architecture.md` — Section 6 Deployment Addresses

Replace all `[DEPLOY_FIRST]` placeholders with actual addresses.

### Contract architecture (deployment order matters)

```
AgentCredential (independent)
     |
     +---> ProofVerifier (independent)
     |         |
     +---> AgentGateway (depends on AgentCredential + ProofVerifier)
     |
     +---> ProofAgentRegistry (depends on AgentCredential)
```

## Troubleshooting

**"Insufficient balance"** — Send at least 0.005 ETH to your deployer wallet on Base mainnet. Use the Coinbase Base bridge or any L2 bridge.

**"BASESCAN_API_KEY not set"** — Verification is optional. Contracts deploy fine without it. You can verify later.

**"Nonce too low"** — Your deployer wallet may have pending transactions. Wait for them to confirm or increase nonce manually.
