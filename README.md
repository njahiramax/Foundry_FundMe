

# Foundry Fund Me

This repo  focuses on building a decentralized crowdfunding contract using Foundry.

---

## ⭐️  Foundry Fund Me

---

## 📦 Project Overview

This contract allows users to fund a smart contract in ETH. The contract uses Chainlink price feeds to enforce a minimum funding threshold in USD.

You'll learn how to:

* Deploy and test smart contracts using Foundry.
* Integrate Chainlink price feeds.
* Work with local and testnet environments.
* Use zkSync for Layer 2 testing.

---

## 🚀 Getting Started

---

### ✅ Requirements

* **Git:** Run `git --version` and confirm you get output like `git version x.x.x`.
* **Foundry:** Run `forge --version` and check for output like `forge 0.2.0 (816e00b...)`.

---

### 🛠️ Quickstart

```bash
git clone https://github.com/Cyfrin/foundry-fund-me-cu
cd foundry-fund-me-cu
make
```

---

### ☁️ Optional: Gitpod

To skip local setup, use Gitpod. No need to clone the repo manually.

[Open in Gitpod](https://gitpod.io/#https://github.com/Cyfrin/foundry-fund-me-cu)

---

## 🧪 Usage

---

### 🔧 Deploy Locally

```bash
forge script script/DeployFundMe.s.sol
```

---

### ✅ Testing

We discuss 4 types of tests:

* Unit
* Integration
* Forked
* Staging

This repo covers Unit and Forked tests.

```bash
forge test
# Or run a specific test
forge test --match-test testFunctionName
# Or forked test
forge test --fork-url $SEPOLIA_RPC_URL
```

---

### 📊 Test Coverage

```bash
forge coverage
```

---

## zkSync Support

This section guides you on running the contract on zkSync locally.

---

### 📋 Additional Requirements

* **foundry-zksync:** Should show version like `forge 0.0.2`.
* **npm & npx:** Run `npm --version` and `npx --version`.
* **Docker:** Should show version like `Docker version 20.10.7`. Make sure the daemon is running (`docker --info`).

---

### 🧱 Setup Local zkSync Node

```bash
npx zksync-cli dev config
# Select: In-memory node, no additional modules

npx zksync-cli dev start
```

You’ll see output like:

```
RPC URL: http://127.0.0.1:8011
Chain ID: 260
```

---

### 🚀 Deploy to zkSync

```bash
make deploy-zk
```

This deploys a mock price feed and FundMe contract on zkSync local node.

---

## 🌍 Deploy to Testnet or Mainnet

---

### 🔐 Setup Environment Variables

Create a `.env` file like `.env.example` and set:

* `SEPOLIA_RPC_URL`: Get one from Alchemy.
* `PRIVATE_KEY`: Use a dev wallet with no real funds.
* (Optional) `ETHERSCAN_API_KEY`: For contract verification.

---

### 🧪 Get Testnet ETH

Use [Chainlink Faucets](https://faucets.chain.link) to get ETH for Sepolia.

---

### 🚀 Deploy

```bash
forge script script/DeployFundMe.s.sol \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --verify \
  --etherscan-api-key $ETHERSCAN_API_KEY
```

---

## 📜 Scripts

Interact with deployed contracts:

### Fund the Contract

```bash
cast send <FUNDME_CONTRACT_ADDRESS> "fund()" \
  --value 0.1ether \
  --private-key <PRIVATE_KEY>
```

Or:

```bash
forge script script/Interactions.s.sol:FundFundMe \
  --rpc-url sepolia \
  --private-key $PRIVATE_KEY \
  --broadcast
```

### Withdraw Funds

```bash
forge script script/Interactions.s.sol:WithdrawFundMe \
  --rpc-url sepolia \
  --private-key $PRIVATE_KEY \
  --broadcast
```

---

## 💸 Withdraw

```bash
cast send <FUNDME_CONTRACT_ADDRESS> "withdraw()" \
  --private-key <PRIVATE_KEY>
```

---

## ⛽ Estimate Gas

```bash
forge snapshot
```

This creates `.gas-snapshot` with gas usage estimates.

---

## 🧹 Code Formatting

```bash
forge fmt
```

---

## ℹ️ Additional Info

Some users were unsure if `chainlink-brownie-contracts` is an official Chainlink repo.

Yes, it is. It's maintained by the Chainlink team under the [smartcontractkit](https://github.com/smartcontractkit/chainlink-brownie-contracts) org.

Instead of pulling code directly from GitHub (which may include unreleased changes), rely on the npm packages that follow Chainlink’s official release cycle.

You have two options:

* Install from npm (adds external dependencies to your Foundry project).
* Use `chainlink-brownie-contracts` (preferred for Foundry compatibility).

---

## 🧾 Summary

* The repo uses an official Chainlink contract package.
* It’s maintained and updated by the smartcontractkit team.
* It wraps official npm releases for easy use with Foundry.

---

## 🙏 Thank You




