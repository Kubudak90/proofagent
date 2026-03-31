# PROOFAGENT — Grant Research
# Date : Mars 2026
# Projet : ZK Authorization Layer for Autonomous AI Agents
# Domaine : proofagent.ch
# Fondateur : Charly Grossrieder — Etienne-plus Sarl (CHE-204.174.717)

---

## 1. Base/Coinbase Ecosystem Grant

### Informations cles
Base (L2 de Coinbase) offre plusieurs voies de financement pour les builders. Le programme est particulierement pertinent car Coinbase pousse massivement les AI Agents via le protocole x402 et les Agentic Wallets. Brian Armstrong a declare que les agents IA feront bientot plus de transactions que les humains via crypto wallets.

### URL de soumission (verifiee le 31 mars 2026)
- **Page principale** : https://docs.base.org/get-started/get-funded (ACTIVE)
- **Builder Grants** : https://paragraph.com/@grants.base.eth/calling-based-builders
- **Base Batches 2026** : https://www.basebatches.xyz/ (ACTIVE)
- **Builder Rewards** : https://www.builderscore.xyz/

### Criteres d'eligibilite
- Projet deploye sur Base mainnet (ou pret a deployer)
- Code shippe > pitch parfait (shipped code over perfect pitches)
- Documentation claire avec instructions de setup
- Metriques d'impact trackees
- Projets early-stage et experiences explicitement encourages

### Format requis
- **Builder Grants (1-5 ETH)** : Pas de formulaire formel — l'equipe Base scout les builders via Twitter, Farcaster, et nominations communautaires. Self-nomination possible via le lien ci-dessus.
- **Base Batches** : Formulaire de candidature sur basebatches.xyz
  - Startup Track : top 15 teams recoivent $10K grant + programme 8 semaines + Demo Day SF
  - Minimum 3 teams recoivent $50K investment du Base Ecosystem Fund
  - Student Track : ouvert aux etudiants du monde entier
- **Weekly Builder Rewards** : 2 ETH/semaine via Builder Score

### Montants (min/max)
| Programme | Montant |
|-----------|---------|
| Weekly Builder Rewards | 2 ETH/semaine |
| Builder Grants (retroactif) | 1-5 ETH (~$2K-$10K) |
| Base Batches grant | $10,000 |
| Base Batches investment | $50,000 (via Base Ecosystem Fund) |
| OP Retro Funding (via Superchain) | Variable |

### Deadlines
- **Builder Grants** : Rolling (pas de deadline fixe)
- **Base Batches 2026 Student Track** : 27 avril 2026
- **Base Batches Startup Track** : Verifier sur basebatches.xyz
- **Weekly Rewards** : Continu

### Projets similaires finances
Le Base Ecosystem Fund (gere par Coinbase Ventures) a investi dans 6+ projets initiaux. Focus sur DeFi, infrastructure, et outils developpeurs. Pas de projet ZK+AI agents specifiquement identifie parmi les grantees publics, ce qui represente une OPPORTUNITE de premier entrant.

### Score fit PROOFAGENT : 9/10
**Raisons du score eleve :**
- Coinbase pousse activement x402 et Agentic Wallets — PROOFAGENT resout le probleme d'autorisation ZK pour ces agents
- Brian Armstrong a identifie le besoin exact que PROOFAGENT adresse
- Base est un L2 Ethereum, compatible avec la stack Circom/Solidity de PROOFAGENT
- Le positionnement "AI Agent authorization layer" est parfaitement aligne avec la vision Coinbase 2026

### Recommandation : OUI — PRIORITE 1
Action immediate : Deployer les smart contracts PROOFAGENT sur Base, accumuler du Builder Score, puis self-nominate pour Builder Grant ET postuler a Base Batches.

---

## 2. Ethereum Foundation ESP (Ecosystem Support Program)

### Informations cles
L'EF a restructure son programme de grants en novembre 2025. L'ancien systeme de candidatures ouvertes a ete remplace par un modele Wishlist + RFP (Request for Proposals). PSE (Privacy & Scaling Explorations) est une equipe interne focalisee sur la privacy.

### URL de soumission (verifiee le 31 mars 2026)
- **ESP principale** : https://esp.ethereum.foundation/ (ACTIVE)
- **Page candidats** : https://esp.ethereum.foundation/applicants (ACTIVE)
- **Wishlist** : https://esp.ethereum.foundation/applicants/wishlist (ACTIVE)
- **RFP** : https://esp.ethereum.foundation/applicants/rfp (ACTIVE)
- **PSE** : https://pse.dev/ (ACTIVE)
- **PSE GitHub** : https://github.com/privacy-scaling-explorations

### Criteres specifiques aux projets ZK
- Tous les outputs doivent etre open-source ou librement disponibles
- Travail gratuit et non-commercial creant des outcomes positifs
- Entreprises for-profit acceptees si le travail finance reste open-source
- Evaluation sur : solidite technique, impact ecosysteme, open-source, rapport cout-efficacite
- Equipe avec experience et competences pertinentes

### Format de soumission
Soumission via formulaire en ligne sur esp.ethereum.foundation. Processus en 6 etapes :
1. Browse les Wishlist/RFP items
2. Soumission detaillee (methodologie, timeline, livrables)
3. Review par l'equipe GM (interviews possibles)
4. Decision par email + KYC + accord legal
5. Execution avec support d'un Grant Evaluator
6. Completion avec rapport public

### Montants typiques
- Determine au cas par cas selon scope et complexite
- PhD Fellowship : $24,000 USD/an
- Grants historiques PSE : $10K-$200K selon le projet
- Pas de montant fixe publie pour les Wishlist/RFP items

### Delais et cycles de review
- Review typique : 3-6 semaines
- Paiement par milestones apres selection
- RFP "RFP Hub" : deadline 23 avril 2026
- RFP "Community Hubs" : deadline 3 juillet 2026
- RFP "Road to Devcon 8" : deadline 20 avril 2026

### Contact PSE
- Email PSE : pse@ethereum.org (a verifier)
- Twitter : @PrivacyScaling
- Lead historique : Barry Whitehat
- Discord PSE accessible via pse.dev
- **Note importante** : PSE n'a PAS de portail de grants classique. Le chemin d'entree est : (a) outreach direct a l'equipe PSE, (b) contribution a un projet PSE existant, (c) reponse a des RFP specifiques.

### Projets ZK recemment finances (pertinents pour PROOFAGENT)
| Projet | Pertinence | Description |
|--------|-----------|-------------|
| Semaphore | Identity/Authorization | Proofs d'appartenance a un groupe anonyme |
| MACI | Authorization/Governance | Anti-collusion ZK pour votes prives |
| Zupass | Identity/Credentials | Verification de credentials ZK |
| TLSNotary | Attestation | Preuve d'authenticite de donnees web via ZK |
| Unirep | Identity/Reputation | Systeme de reputation ZK anonyme |
| Bandada | Group Management | Gestion de groupes privacy-preserving |
| RLN (Rate Limiting Nullifier) | Authorization | Rate limiting ZK anti-spam |

**Note cle** : Aucun projet PSE/ESP combine actuellement ZK + autorisation d'agents IA autonomes. PROOFAGENT serait NOVEL dans cet espace, ce qui est un argument fort.

### ALERTE : Pas de Wishlist/RFP ZK ouverts actuellement
Les RFP actifs (mars 2026) sont :
1. Ethereum Community Hubs (deadline 3 juillet 2026)
2. RFP Hub : Standard RFP Object (deadline 23 avril 2026)
3. Road to Devcon 8 India (deadline 20 avril 2026, max $500)

**Aucun RFP/Wishlist specifiquement ZK ou AI agents n'est ouvert.** Le seul Wishlist item actif concerne les outils developpeurs existants.

### Score fit PROOFAGENT : 6/10
**Raisons :**
- (+) PSE est le lieu naturel pour les projets ZK privacy
- (+) L'EF valorise les projets open-source d'infrastructure
- (-) Pas de Wishlist/RFP ZK ou AI ouvert actuellement
- (-) Processus restructure, nouveaux items a venir mais timing incertain
- (-) Necessiterait d'attendre un prochain cycle pertinent

### Recommandation : PEUT-ETRE — SURVEILLER
Surveiller esp.ethereum.foundation/applicants/wishlist pour de nouveaux items ZK/privacy. Contacter PSE directement via pse.dev pour explorer une collaboration. Ne pas soumettre maintenant car aucun item ne correspond.

---

## 3. Arbitrum Foundation

### Informations cles
Arbitrum a lance les programmes Trailblazer ($1M) et Trailblazer 2.0 ($1M) specifiquement pour les AI agents et Agentic DeFi — parfaitement alignes avec PROOFAGENT. CEPENDANT, les deux programmes sont marques comme "COMPLETE" sur le site officiel.

### URL de soumission (verifiee le 31 mars 2026)
- **Page grants principale** : https://arbitrum.foundation/grants (ACTIVE)
- **Questbook** : https://arbitrum.questbook.app (ACTIVE)
- **Blog** : https://blog.arbitrum.foundation/

### Nouvelles categories ouvertes en 2026
**Programmes ACTIFS :**
- **Arbitrum DAO Grant Program** (via Questbook) : milestone-based, rolling
  - Growth Track : $20,000-$60,000 (min 2 milestones)
  - Advanced Growth Track : $60,000-$150,000 (min 3 milestones)
- **Arbitrum Audit Program** : $10M en ARB sur 12 mois pour audits
- **Alchemy-Arbitrum Grant** : jusqu'a $500K en credits infrastructure
- **Mentorship Program** : jusqu'a 15 teams

**Programmes TERMINES (pertinents mais fermes) :**
- Trailblazer AI : $1M pour AI agents (COMPLETE)
- Trailblazer 2.0 : $1M pour Agentic DeFi (COMPLETE)
- Stylus Sprint : 5M ARB (COMPLETE)

### Contact
- Email potentiel : grants@arbitrum.foundation (a verifier)
- Governance Forum : forum.arbitrum.foundation (categorie grants)
- Discord : canal grants dans le Discord Arbitrum
- Twitter : @ArbitrumFDN

### Processus pour projets ayant deja recu un grant
Resoumission possible via Questbook. Les projets doivent expliquer l'evolution depuis le precedent grant. Rapport de progres et KPIs requis avant renouvellement.

### Format exact de soumission
Via Questbook (arbitrum.questbook.app) :
- Application en ligne
- Milestones definis
- Approbation rolling basis
- Eligible : dApps sur Arbitrum One, Nova, Orbit ou Stylus

### Montants disponibles
| Programme | Montant |
|-----------|---------|
| Growth Track | $20K-$60K |
| Advanced Growth Track | $60K-$150K |
| Audit Program | Jusqu'a $10M ARB total |
| Alchemy credits | Jusqu'a $500K/team |

### Score fit PROOFAGENT : 7/10
**Raisons :**
- (+) PROOFAGENT a deja des smart contracts deployes sur Arbitrum
- (+) Le DAO Grant Program est actif et rolling
- (+) Les Trailblazer AI montrent que l'ecosysteme valorise les AI agents
- (-) Les programmes AI-specifiques (Trailblazer) sont fermes
- (-) Le Growth Track generique est moins cible que Base pour notre use case

### Recommandation : OUI — PRIORITE 2
Postuler au Growth Track ($20K-$60K) via Questbook en mettant en avant le deployment existant sur Arbitrum et le use case AI agents. Surveiller l'annonce d'un potentiel Trailblazer 3.0.

---

## 4. Autres programmes identifies

### 4.1 Starknet Foundation — Seed Grants

#### Informations cles
Programme de grants pour early-stage projects sur Starknet (ZK-STARK natif).

#### URL de soumission (verifiee le 31 mars 2026)
- https://www.starknet.io/grants/ (ACTIVE)
- https://www.starknet.io/grants/seed-grants/ (ACTIVE)

#### Criteres d'eligibilite
- MVP ou Proof of Concept requis
- Participation active dans la communaute Starknet ou hackathon
- Plan clair d'utilisation des fonds sur 3 mois
- Pas encore live sur Starknet avec user base etablie

#### Format requis
Formulaire de candidature en ligne sur starknet.io/grants

#### Montants
- Seed Grants : jusqu'a $25,000 en STRK
- Growth Grants : jusqu'a $1,000,000 en STRK (projets matures)

#### Deadlines
- Rolling (pas de deadline fixe)
- Reponse en ~4 semaines

#### Score fit PROOFAGENT : 5/10
- (+) Ecosysteme ZK natif (STARK)
- (+) Montants interessants
- (-) PROOFAGENT utilise Circom (SNARK), pas Cairo (STARK)
- (-) Necessite un port vers l'ecosysteme Starknet
- (-) Effort de portage vs. benefice incertain

#### Recommandation : NON pour l'instant
Le portage vers Cairo/STARK n'est pas justifie a ce stade. A reconsiderer si Starknet lance un programme AI agents specifique.

---

### 4.2 Optimism RetroPGF (Retro Funding)

#### Informations cles
Financement retroactif des biens publics. Base fait partie du Superchain Optimism, donc un projet sur Base peut aussi beneficier du RetroPGF.

#### URL de soumission (verifiee le 31 mars 2026)
- https://atlas.optimism.io/ (ACTIVE)
- https://gov.optimism.io/c/retrofunding/46

#### Criteres
- Impact demonstrable sur l'ecosysteme (code open-source, outils, infrastructure)
- Metriques qualitatives et quantitatives d'impact
- Etre un "bien public" pour l'ecosysteme

#### Montants
- Variable (millions de OP distribues par round)
- RetroPGF evolue vers un modele d'evaluation continue

#### Score fit PROOFAGENT : 6/10
- (+) Complementaire a la strategie Base
- (+) Recompense le travail deja accompli
- (-) Retroactif = il faut d'abord avoir de l'impact
- (-) Processus competitif avec beaucoup de candidats

#### Recommandation : PEUT-ETRE — A MOYEN TERME
S'inscrire sur OP Atlas maintenant, deployer sur Base/Optimism, puis candidater une fois l'impact demontre.

---

### 4.3 Polygon Community Grants

#### Informations cles
Programme massif ($100M POL/an) pour l'ecosysteme Polygon.

#### URL de soumission (verifiee le 31 mars 2026)
- https://polygon.technology/grow (ACTIVE)
- https://polygon.questbook.xyz/

#### Criteres
- Tout projet sur Polygon eligible (DeFi, NFT, DAO, ZK, outils)
- ZK developers explicitement bienvenus

#### Montants
- Jusqu'a $100M POL en financement par an
- Montants individuels variables selon track

#### Score fit PROOFAGENT : 6/10
- (+) PROOFAGENT a des smart contracts deployes sur Polygon
- (+) Budget massif
- (+) ZK est prioritaire pour Polygon
- (-) Moins d'alignement specifique AI agents
- (-) Polygon se repositionne (AggLayer), direction incertaine

#### Recommandation : OUI — PRIORITE 3
Postuler en parallele, en mettant en avant le deployment existant sur Polygon.

---

### 4.4 a16z Crypto Startup School (CSX)

#### Informations cles
Accelerateur 12 semaines par Andreessen Horowitz crypto.

#### URL de soumission
- https://a16zcrypto.com/accelerator/

#### Criteres
- Startup early-stage dans le crypto
- Equipe motivee avec vision produit

#### Montants
- $500,000 pour 7% equity (standard)
- Plus mentorship, reseau, et acces VCs

#### Score fit PROOFAGENT : 7/10
- (+) a16z identifie "Know Your Agent" (KYA) comme primitive manquante — exactement PROOFAGENT
- (+) $500K est significatif
- (+) Acces au reseau a16z
- (-) Dilutif (7% equity)
- (-) Tres competitif
- (-) Necessite relocation potentielle

#### Recommandation : PEUT-ETRE — EXPLORER
Candidater au prochain cycle. Le fit thematique est excellent (a16z parle de KYA, credentials pour agents), mais c'est un accelerateur, pas un grant.

---

### 4.5 Gitcoin Grants

#### Informations cles
Programme en restructuration majeure en 2026. Transition vers modele "Domain Allocator" et possible sunset du format actuel.

#### URL de soumission
- https://grants.gitcoin.co/ (ACTIVE)

#### Score fit PROOFAGENT : 4/10
- (-) Programme en restructuration
- (-) Montants modestes (matching funds communautaires)
- (-) Incertitude sur le futur du programme
- (+) Bonne visibilite communautaire

#### Recommandation : NON — Trop incertain actuellement

---

### 4.6 EF ZK Grants Round (Collaborative)

#### Informations cles
Round collaboratif entre EF, Aztec, Polygon, Scroll, Taiko, et zkSync. Pool total de $900K ($150K par participant).

#### URL de soumission
- https://esp.ethereum.foundation/zk-grants/

#### Statut
Le dernier round identifie avait une deadline le 18 mars (annee non confirmee pour 2026). A VERIFIER si un nouveau round est annonce.

#### Score fit PROOFAGENT : 8/10 (si ouvert)
- (+) Specifiquement pour projets ZK
- (+) Pool significatif ($900K)
- (+) Multi-ecosysteme
- (-) Statut actuel incertain

#### Recommandation : OUI si ouvert — SURVEILLER ACTIVEMENT
Verifier regulierement si un nouveau ZK Grants Round est annonce.

---

## 5. Tableau comparatif final

| Programme | Montant est. | Delai reponse | Fit (1-10) | Difficulte | Priorite |
|-----------|-------------|---------------|------------|------------|----------|
| Base Builder Grant + Batches | $10K-$50K | 2-4 sem | 9/10 | Moyenne | **1** |
| Arbitrum DAO Growth Track | $20K-$60K | 4-6 sem | 7/10 | Moyenne | **2** |
| Polygon Community Grants | Variable | 4-8 sem | 6/10 | Moyenne | **3** |
| a16z CSX | $500K (dilutif) | 8-12 sem | 7/10 | Tres haute | 4 |
| EF ZK Grants Round | ~$50K-$150K | 6-8 sem | 8/10 | Haute | Surveiller |
| EF ESP Wishlist/RFP | Variable | 3-6 sem | 6/10 | Haute | Surveiller |
| Optimism RetroPGF | Variable | Variable | 6/10 | Moyenne | Moyen terme |
| Starknet Seed | $25K STRK | 4 sem | 5/10 | Basse | Non |
| Gitcoin | Faible | Variable | 4/10 | Basse | Non |

---

## 6. Recommandation finale

### Programme #1 a attaquer : BASE / COINBASE ECOSYSTEM
**Raison en 3 points :**
1. **Alignement strategique maximal** : Coinbase pousse x402/Agentic Wallets — PROOFAGENT est le layer ZK d'autorisation manquant pour ces agents. C'est le fit produit-marche le plus direct.
2. **Facilite d'execution** : Deployer sur Base, accumuler du Builder Score, et self-nominate. Pas de formulaire complexe, pas de bureaucratie lourde.
3. **Effet de levier** : Un grant Base donne visibilite aupres de Coinbase Ventures et ouvre la porte a Base Batches ($50K+). Le narratif "ZK auth for Coinbase AI agents" est puissant.

### Programme #2 en parallele : ARBITRUM DAO GROWTH TRACK
**Raison en 2 points :**
1. **Deployment existant** : PROOFAGENT a deja des smart contracts sur Arbitrum, ce qui reduit la friction de candidature et demontre un engagement ecosysteme.
2. **Track record AI** : Les programmes Trailblazer 1.0 et 2.0 montrent que l'ecosysteme Arbitrum valorise les projets AI agents — meme si fermes, le DAO Grant Program peut financer des projets similaires.

### Action immediate recommandee
1. Deployer les contracts PROOFAGENT sur Base mainnet cette semaine
2. S'inscrire sur builderscore.xyz pour commencer a accumuler du Builder Score
3. Preparer une self-nomination pour le Builder Grant
4. En parallele, preparer une application Questbook pour Arbitrum Growth Track
5. Surveiller les annonces EF pour un nouveau ZK Grants Round
