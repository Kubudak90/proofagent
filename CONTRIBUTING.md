# Contributing to PROOFAGENT

Thank you for your interest in contributing to PROOFAGENT! This document provides guidelines and instructions for contributing to the ZK Authorization Layer for Autonomous AI Agents.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contributing Guidelines](#contributing-guidelines)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Security](#security)

## Code of Conduct

This project and everyone participating in it is governed by our commitment to:
- Be respectful and inclusive
- Focus on constructive feedback
- Prioritize privacy and security
- Support the autonomous AI agent ecosystem

## Getting Started

### Prerequisites

- **Node.js** v18 or higher
- **npm** v9 or higher
- **Git**
- **Python** 3.9+ (for backend/FastAPI components)
- Basic understanding of:
  - Zero-knowledge proofs (Circom)
  - Solidity smart contracts
  - Base blockchain ecosystem

### Repository Structure

```
proofagent/
├── circuits/          # Circom ZK circuits
├── contracts/         # Solidity smart contracts
├── backend/           # FastAPI Python backend
├── frontend/          # Next.js frontend
├── test/              # Test suites
├── scripts/           # Deployment and utility scripts
└── docs/              # Documentation
```

## Development Setup

1. **Fork and clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/proofagent.git
   cd proofagent
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

4. **Compile contracts**
   ```bash
   npm run compile
   ```

5. **Run tests**
   ```bash
   npm test
   ```

## Contributing Guidelines

### What We're Looking For

- **Bug fixes** for existing contracts or circuits
- **Documentation improvements** (README, code comments, deployment guides)
- **Test coverage** for edge cases
- **Performance optimizations** for circuits
- **Integration examples** for AI agent frameworks
- **Security audits** and vulnerability reports

### What We're NOT Looking For

- Breaking changes without discussion
- Changes that compromise ZK privacy guarantees
- Code without proper tests
- Spam or low-quality PRs

### Coding Standards

#### Solidity
- Follow [Solidity Style Guide](https://docs.soliditylang.org/en/latest/style-guide.html)
- Use NatSpec comments for all public functions
- Maximum line length: 120 characters
- Use explicit function visibility modifiers

#### Circom
- Document circuit constraints with comments
- Include input/output signal descriptions
- Optimize for constraint minimization

#### Python (Backend)
- Follow [PEP 8](https://pep8.org/)
- Use type hints
- Document functions with docstrings

#### TypeScript/JavaScript
- Use ESLint configuration provided
- Prefer `const` and `let` over `var`
- Use async/await for asynchronous operations

## Testing

### Running Tests

```bash
# Run all tests
npm test

# Run contract tests only
npm run test:contracts

# Run circuit tests only
npm run test:circuits

# Run with coverage
npm run test:coverage
```

### Test Requirements

- All new features must include tests
- Bug fixes should include regression tests
- Maintain minimum 80% code coverage
- Tests must pass on Base Sepolia before mainnet

### Test Networks

- **Base Sepolia**: Primary testnet for development
- **Local Hardhat network**: For rapid iteration

## Submitting Changes

### Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow coding standards
   - Add/update tests
   - Update documentation

3. **Commit your changes**
   ```bash
   git add .
   git commit -m "type: description"
   ```
   
   Commit message format:
   - `feat:` New feature
   - `fix:` Bug fix
   - `docs:` Documentation changes
   - `test:` Test additions/changes
   - `refactor:` Code refactoring
   - `perf:` Performance improvements
   - `chore:` Maintenance tasks

4. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Create Pull Request**
   - Fill out the PR template
   - Link related issues
   - Provide clear description of changes
   - Include test results

### PR Review Process

- All PRs require at least one review
- Address review feedback promptly
- CI checks must pass before merge
- Squash commits if requested

## Security

### Reporting Vulnerabilities

**DO NOT** open public issues for security vulnerabilities.

Instead, email: security@proofagent.ch

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

### Security Best Practices

- Never commit private keys or `.env` files
- Use test networks for development
- Verify contracts on Basescan after deployment
- Follow [Consensys Smart Contract Best Practices](https://consensys.github.io/smart-contract-best-practices/)

## Questions?

- Open an issue for general questions
- Join our community discussions
- Contact: hello@proofagent.ch

## Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Eligible for future token rewards (if applicable)

Thank you for helping build the future of autonomous AI agent authorization!

---

**PROOFAGENT** — Empowering AI agents with privacy-preserving authorization.
