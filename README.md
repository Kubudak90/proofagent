# PROOFAGENT
## ZK Authorization Layer for Autonomous AI Agents
## proofagent.ch

PROOFAGENT permet aux agents IA autonomes de prouver cryptographiquement
qu'ils sont autorises a effectuer des actions (paiements, acces API,
transactions onchain) sans reveler l'identite de leur proprietaire
ni le scope complet de leurs permissions.

Construit sur la stack technique de PRIVEX (privexzk.ch).
Fonde par Charly Grossrieder — Etienne-plus Sarl (CHE-204.174.717), Geneve, Suisse.

### Stack technique
- **Circuits ZK** : Circom (age verification valide sur Sepolia)
- **Smart Contracts** : Solidity deployes sur Arbitrum, Base, Linea, Polygon, BSC
- **Credentials** : Soul Bound Tokens (SBTs) non-transferables
- **Backend** : FastAPI Python
- **Frontend** : Next.js
- **Infrastructure** : Supabase + Vercel + Cloudflare

### Client cible
Builders d'agents IA autonomes necessitant une couche d'autorisation ZK
pour interagir avec des protocoles de paiement (x402 Coinbase, USDC)
et des APIs tierces — sans exposer les credentials du proprietaire humain.

### Deployed Contracts — Ethereum Sepolia (chainId: 11155111)
| Contract | Address | Etherscan |
|----------|---------|-----------|
| AgentCredential | `0x48BED46b86A5B2Df444EAc462a04E47AC892eC6D` | [View](https://sepolia.etherscan.io/address/0x48BED46b86A5B2Df444EAc462a04E47AC892eC6D) |
| ProofVerifier | `0x583b00aE28dFB28ab4Bf4b0c79F212C85C4F70fD` | [View](https://sepolia.etherscan.io/address/0x583b00aE28dFB28ab4Bf4b0c79F212C85C4F70fD) |
| AgentGateway | `0x704E4D911f9a56C2b296C9D13718eA53A5E6da02` | [View](https://sepolia.etherscan.io/address/0x704E4D911f9a56C2b296C9D13718eA53A5E6da02) |
| ProofAgentRegistry | `0xE31722f304A2b3Bc2B65a5bbC32B4c6E119a7f2f` | [View](https://sepolia.etherscan.io/address/0xE31722f304A2b3Bc2B65a5bbC32B4c6E119a7f2f) |

*Deployer: `0x128dA3f08c125C6658C3978acB65213F58E93Cb1` — 31 mars 2026*
*Base mainnet deployment scheduled as Milestone 1 upon grant approval.*

### Statut
- Grant research complete le 31 mars 2026
- Smart contracts deployes et verifies sur Ethereum Sepolia le 31 mars 2026
- Voir `research/grant_research.md` pour l'analyse detaillee
- Voir `research/grant_checklist.md` pour la checklist de soumission
- Voir `deployments/sepolia_addresses.json` pour les adresses de deploiement

### Prochaines etapes
1. **Soumettre grant Base Builder Grant** avant le 27 avril 2026
2. **Deployer sur Base mainnet** une fois le grant approuve (Milestone 1)
3. **Soumettre Arbitrum Growth Track** via Questbook en parallele
