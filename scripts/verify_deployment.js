// PROOFAGENT — Post-Deployment Verification Script
// Usage: npx hardhat run scripts/verify_deployment.js --network sepolia

const hre = require("hardhat");
const fs = require("fs");
const path = require("path");

async function main() {
  const network = await hre.ethers.provider.getNetwork();
  console.log(`\n=== PROOFAGENT DEPLOYMENT VERIFICATION ===`);
  console.log(`Network: ${network.name} (chainId: ${network.chainId})\n`);

  // Load addresses
  let filename;
  if (network.chainId === 11155111n) filename = "sepolia_addresses.json";
  else if (network.chainId === 8453n) filename = "base_mainnet_addresses.json";
  else if (network.chainId === 84532n) filename = "base_sepolia_addresses.json";
  else filename = `deployment_${network.chainId}.json`;

  const addrPath = path.join(__dirname, "..", "deployments", filename);
  if (!fs.existsSync(addrPath)) {
    console.error(`ERROR: ${filename} not found. Deploy first.`);
    process.exit(1);
  }

  const deployment = JSON.parse(fs.readFileSync(addrPath, "utf8"));
  const contracts = deployment.contracts;

  let passed = 0;
  let failed = 0;

  // 1. AgentCredential — check name()
  try {
    const credential = await hre.ethers.getContractAt("AgentCredential", contracts.AgentCredential);
    const name = await credential.name();
    console.log(`✅ AgentCredential  → name() = "${name}"`);
    passed++;
  } catch (e) {
    console.log(`❌ AgentCredential  → FAILED: ${e.message.slice(0, 80)}`);
    failed++;
  }

  // 2. ProofVerifier — check it responds (get code)
  try {
    const code = await hre.ethers.provider.getCode(contracts.ProofVerifier);
    if (code !== "0x") {
      console.log(`✅ ProofVerifier    → Contract deployed (${code.length} bytes bytecode)`);
      passed++;
    } else {
      console.log(`❌ ProofVerifier    → No bytecode at address`);
      failed++;
    }
  } catch (e) {
    console.log(`❌ ProofVerifier    → FAILED: ${e.message.slice(0, 80)}`);
    failed++;
  }

  // 3. AgentGateway — check totalAuthorizations()
  try {
    const gateway = await hre.ethers.getContractAt("AgentGateway", contracts.AgentGateway);
    const total = await gateway.totalAuthorizations();
    console.log(`✅ AgentGateway     → totalAuthorizations() = ${total}`);
    passed++;
  } catch (e) {
    console.log(`❌ AgentGateway     → FAILED: ${e.message.slice(0, 80)}`);
    failed++;
  }

  // 4. ProofAgentRegistry — check isRegisteredAgent(address(0))
  try {
    const registry = await hre.ethers.getContractAt("ProofAgentRegistry", contracts.ProofAgentRegistry);
    const isRegistered = await registry.isRegisteredAgent("0x0000000000000000000000000000000000000000");
    console.log(`✅ ProofAgentRegistry → isRegisteredAgent(0x0) = ${isRegistered}`);
    passed++;
  } catch (e) {
    console.log(`❌ ProofAgentRegistry → FAILED: ${e.message.slice(0, 80)}`);
    failed++;
  }

  // Summary
  console.log(`\n=== VERIFICATION RESULT: ${passed}/4 passed, ${failed}/4 failed ===`);
  if (failed === 0) {
    console.log("🎉 All contracts verified and responsive!\n");
  } else {
    console.log("⚠️  Some contracts failed verification.\n");
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
