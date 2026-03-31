// PROOFAGENT — Base Mainnet Deployment Script
// Usage: npx hardhat run scripts/deploy_base_mainnet.js --network base

const hre = require("hardhat");
const fs = require("fs");
const path = require("path");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  const balance = await hre.ethers.provider.getBalance(deployer.address);
  const network = await hre.ethers.provider.getNetwork();

  console.log("\n=== PROOFAGENT BASE DEPLOYMENT ===");
  console.log(`Network:  ${network.name} (chainId: ${network.chainId})`);
  console.log(`Deployer: ${deployer.address}`);
  console.log(`Balance:  ${hre.ethers.formatEther(balance)} ETH`);
  console.log("==================================\n");

  if (balance < hre.ethers.parseEther("0.003")) {
    console.error("ERROR: Insufficient balance. Need at least 0.003 ETH for deployment gas.");
    process.exit(1);
  }

  // ─── 1. Deploy AgentCredential ───────────────────────────────────
  console.log("1/4 Deploying AgentCredential (SBT)...");
  const AgentCredential = await hre.ethers.getContractFactory("AgentCredential");
  const agentCredential = await AgentCredential.deploy();
  await agentCredential.waitForDeployment();
  const credentialAddr = await agentCredential.getAddress();
  console.log(`     AgentCredential: ${credentialAddr}`);

  // ─── 2. Deploy ProofVerifier ─────────────────────────────────────
  console.log("2/4 Deploying ProofVerifier (Groth16)...");
  const ProofVerifier = await hre.ethers.getContractFactory("ProofVerifier");
  const proofVerifier = await ProofVerifier.deploy();
  await proofVerifier.waitForDeployment();
  const verifierAddr = await proofVerifier.getAddress();
  console.log(`     ProofVerifier:   ${verifierAddr}`);

  // ─── 3. Deploy AgentGateway ──────────────────────────────────────
  console.log("3/4 Deploying AgentGateway (x402 integration)...");
  const AgentGateway = await hre.ethers.getContractFactory("AgentGateway");
  const agentGateway = await AgentGateway.deploy(credentialAddr, verifierAddr);
  await agentGateway.waitForDeployment();
  const gatewayAddr = await agentGateway.getAddress();
  console.log(`     AgentGateway:    ${gatewayAddr}`);

  // ─── 4. Deploy ProofAgentRegistry ────────────────────────────────
  console.log("4/4 Deploying ProofAgentRegistry...");
  const ProofAgentRegistry = await hre.ethers.getContractFactory("ProofAgentRegistry");
  const registry = await ProofAgentRegistry.deploy(credentialAddr);
  await registry.waitForDeployment();
  const registryAddr = await registry.getAddress();
  console.log(`     ProofAgentRegistry: ${registryAddr}`);

  // ─── Save Deployment Addresses ───────────────────────────────────
  const deployment = {
    network: network.chainId === 8453n ? "base-mainnet" : network.chainId === 11155111n ? "ethereum-sepolia" : `chain-${network.chainId}`,
    chainId: Number(network.chainId),
    deployedAt: new Date().toISOString(),
    deployer: deployer.address,
    contracts: {
      AgentCredential: credentialAddr,
      ProofVerifier: verifierAddr,
      AgentGateway: gatewayAddr,
      ProofAgentRegistry: registryAddr,
    },
    explorer: {
      AgentCredential: `https://${network.chainId === 11155111n ? "sepolia.etherscan.io" : "basescan.org"}/address/${credentialAddr}`,
      ProofVerifier: `https://${network.chainId === 11155111n ? "sepolia.etherscan.io" : "basescan.org"}/address/${verifierAddr}`,
      AgentGateway: `https://${network.chainId === 11155111n ? "sepolia.etherscan.io" : "basescan.org"}/address/${gatewayAddr}`,
      ProofAgentRegistry: `https://${network.chainId === 11155111n ? "sepolia.etherscan.io" : "basescan.org"}/address/${registryAddr}`,
    },
  };

  const deploymentsDir = path.join(__dirname, "..", "deployments");
  if (!fs.existsSync(deploymentsDir)) {
    fs.mkdirSync(deploymentsDir, { recursive: true });
  }

  let filename;
  if (network.chainId === 8453n) filename = "base_mainnet_addresses.json";
  else if (network.chainId === 84532n) filename = "base_sepolia_addresses.json";
  else if (network.chainId === 11155111n) filename = "sepolia_addresses.json";
  else filename = `deployment_${network.chainId}.json`;

  fs.writeFileSync(
    path.join(deploymentsDir, filename),
    JSON.stringify(deployment, null, 2)
  );

  // ─── Summary ─────────────────────────────────────────────────────
  console.log("\n=== DEPLOYMENT COMPLETE ===");
  console.log(`AgentCredential:     ${credentialAddr}`);
  console.log(`ProofVerifier:       ${verifierAddr}`);
  console.log(`AgentGateway:        ${gatewayAddr}`);
  console.log(`ProofAgentRegistry:  ${registryAddr}`);
  console.log(`\nSaved to: deployments/${filename}`);
  console.log("===========================\n");

  // ─── Verify on Basescan (optional) ───────────────────────────────
  if (process.env.BASESCAN_API_KEY) {
    console.log("Verifying contracts on Basescan...\n");

    const contracts = [
      { name: "AgentCredential", address: credentialAddr, args: [] },
      { name: "ProofVerifier", address: verifierAddr, args: [] },
      { name: "AgentGateway", address: gatewayAddr, args: [credentialAddr, verifierAddr] },
      { name: "ProofAgentRegistry", address: registryAddr, args: [credentialAddr] },
    ];

    for (const c of contracts) {
      try {
        await hre.run("verify:verify", {
          address: c.address,
          constructorArguments: c.args,
        });
        console.log(`  ${c.name}: Verified`);
      } catch (err) {
        console.log(`  ${c.name}: ${err.message.includes("Already") ? "Already verified" : err.message}`);
      }
    }
  } else {
    console.log("Skipping Basescan verification (no BASESCAN_API_KEY in .env).");
    console.log("To verify later: npx hardhat verify --network base <address> [constructor args]");
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
