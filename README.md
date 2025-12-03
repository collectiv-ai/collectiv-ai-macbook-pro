<p align="center">
  <img src="logo.png" alt="CollectivAI Logo" width="400" />
</p>

# CollectiVAI – macOS M2 Max Ecosystem Overview

This repository documents the **full local ecosystem** running on a  
**MacBook Pro 16" – Apple M2 Max, 64 GB RAM, 12 CPU, 38 GPU, 2 TB SSD (macOS 26.1)**.

It serves as the primary **blue-team / AI / orchestration machine** within the broader  
**CollectivAI** environment (macOS + Kali + Ubuntu/Bittensor + nodes & agents).

## Focus of this Setup

- **100% local & offline-capable AI** (PrivateGPT + Ollama)
- Deep integration of **AI + blockchain + security tooling**
- A clean, script-driven **Control Center** for daily operations

---

## 1. Host System

### Hardware

- Device: MacBook Pro 16"
- SoC: Apple M2 Max
- RAM: 64 GB
- CPU 12 (8/4)
- GPU 38
- Internal SSD: 2 TB
- Main OS: macOS 15.1 (Tahoe 26.1)

### Runtime Snapshot

- macOS 26.1, build 24B83  
- Plenty of free disk space on `/`  
- RAM heavily used by AI/agents, but still sufficient headroom for concurrent workloads  

The machine is designed as a **permanent lab & control plane**, not a minimal install.

---

## 2. Python & Environments

The Mac acts as a **Python hub** for AI, agents, bots, and trading systems.

### 2.1 Global Python

- Primary Python: **Python 3.13.x** (Homebrew)
- A rich global environment with thousands of packages, including:

#### AI / LLM & Tooling

- `openai`, `anthropic`, `google-genai`, `litellm`  
- `llama-index*`, `langchain*`, `llama-parse`  
- `jupyter`, `jupyterlab`

#### Web / APIs / Frameworks

- `fastapi`, `uvicorn`, `Flask`, `gradio`, `streamlit`  
- `websockets`, `httpx`, `requests`

#### Data & Science

- `pandas`, `numpy`, `scipy`, `matplotlib`, `scikit-learn`, `statsmodels`

#### Crypto / Blockchain

- `web3`, `eth-account`, `ccxt`, `freqtrade`, `tronpy`, `Riskfolio-Lib`

#### Agent & Automation Frameworks

- `autogen`, `autogen-agentchat`, `autogen-core`  
- `crewai`, `deepeval`, `open-interpreter`

#### Observability / Telemetry

- OpenTelemetry stack (`opentelemetry-*`)

> The global environment is intentionally **rich** – this Mac is the main lab for AI agents, orchestration, trading bots, and infrastructure.

---

### 2.2 pipx Apps

`pipx` is used to isolate complex tools into dedicated venvs, such as:

- `aider-chat`, `autogenstudio`, `chromadb`, `crewai`
- `cryptoadvance-specter`, `freqtrade`, `glances`, `gpt-engineer`
- `jupyterlab`, `langchain-cli`, `langgraph-cli`
- `open-interpreter`, `open-webui`, `poetry`, `streamlit`

All live under `~/.local/pipx/venvs`, fully separated from system Python.

---

### 2.3 Agent & Bot Environments

Under `~/ai-agents/` there is a **full fleet of agent and bot environments**:

#### Agent Frameworks & Tools

- `autogenstudio`, `crewai`, `openai-bot`, `ai-bot`  
- `open-interpreter`, `superagent`, `agent-llm`, `metagpt`, `opendevin`

#### Social / Comms Bots

- `telegram-bot`, `telegram-broadcast-hub`, `discord-bot`, `slack-bot`  
- `mastodon-bot`, `matrix-bot`, `twitter-bot`, `reddit-bot`, `linkedin-bot`

#### Trading & Crypto

- `hummingbot`, `trading-bot`, `ccxt-bot`, `jesse`, `freqtrade`

#### Utilities / Glue

- `tools`, `voice-bot`, `whisper-bot`, `github-bot`, `lc-li`

Each subproject has its own `requirements.txt` and venv, allowing **clean isolation**.

---

## 3. Local LLM Stack (Ollama + PrivateGPT)

The system uses a **local-only LLM stack**:

- **Ollama** as the main model server (`ollama serve` on `127.0.0.1:11434`)
- **PrivateGPT** (in `~/AI/private-gpt`) configured to talk to Ollama  
  → **no OpenAI / cloud LLM dependency**

PrivateGPT is started via a wrapper script (e.g. `pgpt-ollama.sh`) that selects an Ollama model like:

- `llama3.1:8b` as the main general-purpose model

### Subset of the Ollama Model Zoo

#### General / Chat / Reasoning

- `llama3.1:8b`, `llama3:latest`, `mistral:latest`, `neural-chat:latest`, `openchat:latest`  
- `zephyr:latest`, `vicuna:latest`, `openhermes:latest`, `nous-hermes2:latest`

#### Code-Focused

- `deepseek-coder-v2:16b`, `deepseek-coder:6.7b`  
- `qwen2.5-coder:7b`, `qwen2.5-coder:14b`  
- `codellama:latest`, `codellama:13b-instruct`  
- `codestral:latest`, `sqlcoder:7b`

#### Vision & Multimodal

- `llava:latest`, `llava:13b`, `llava:34b`  
- `bakllava:latest`, `moondream:latest`

#### Reasoning / R1-style

- `deepseek-r1:7b`, `deepseek-r1:14b`

#### Embedding / Retrieval

- `nomic-embed-text:latest`, `mxbai-embed-large:latest`, `bge-m3:latest`

#### Lightweight / Experimental

- `tinyllama:latest`, `gemma:2b`, `phi3:mini`, `phi3:medium`

> The entire LLM pipeline runs **locally and offline**.  
> PrivateGPT + Ollama provide a self-contained, privacy-first AI stack.

---

## 3.1 Table of Contents

1. [Host System](#1-host-system)
2. [Python & Environments](#2-python--environments)
3. [Local LLM Stack (Ollama + PrivateGPT)](#3-local-llm-stack-ollama--privategpt)
4. [Blockchain & Crypto Infrastructure](#4-blockchain--crypto-infrastructure)
5. [Security, Networking & Privacy](#5-security-networking--privacy)
6. [Bots & Social Integrations](#6-bots--social-integrations)
7. [Ecosystem Scripts & Control Center](#7-ecosystem-scripts-control-center--audits)
8. [Role of This Mac](#8-role-of-this-mac-in-the-collectivai-architecture)
9. [Hackberry CM5 Edge Nodes](#81-edge-nodes--security-lab--hackberry-cm5)
10. [Next Steps](#9-next-steps)
11. [What this lab enables](#10-what-this-lab-enables)

---

## 4. Blockchain & Crypto Infrastructure

The Mac also acts as a **full crypto & smart contract lab**.

### 4.1 Bitcoin

- `bitcoind` – Bitcoin Core v30.0.0 (full node)
- `bitcoin-cli` – RPC access and inspection
- Helper scripts (see section 7) for sync monitoring and node status

### 4.2 Ethereum & EVM

- `geth` – Go Ethereum 1.16.x
- `solc` – Solidity compiler
- `forge`, `cast`, `anvil` – Foundry toolchain
- `hardhat` – JavaScript-based smart contract framework
- `eth-brownie` – Python-based Ethereum dev stack

### 4.3 Trading & Bots

- `freqtrade`, `ccxt`, `jesse`, `backtrader` and others  
- Used for strategy research and AI-assisted trading simulations

> Design goal: one macOS machine as a unified **AI + blockchain research node**.

---

## 5. Security, Networking & Privacy

Security and privacy are **first-class citizens** in this setup.

### Firewall

- LuLu firewall: **active** and monitoring outbound connections

### VPN

- VPN interface (`utun*`) active – used for anonymisation & geo abstraction

### Tor

- System-level `tor` service on `127.0.0.1:9050`  
- Integrated into the DNS stack and available for agents & CLI tools

### DNS / Leak Protection

- DNS-over-Tor with `dnscrypt-proxy`  
- Dedicated scripts to configure, fix and reset dnscrypt and prevent DNS leaks

### Security Tools

- `crowdsec`, `fail2ban` installed (can be enabled when needed)

### Exposed Local Services

- `ollama` on `127.0.0.1:11434` (+ IPv6)  
- `tor` on `127.0.0.1:9050`

---

## 6. Bots & Social Integrations

Several **social and messaging bots** are integrated and live under `~/ai-agents/`:

- Telegram, Discord, Slack, Mastodon, Reddit, Matrix, Twitter/X, LinkedIn  
- Mail bots (IMAP/SMTP), GitHub bot, Whisper-based voice bot  

All bots run in separate venvs with `requirements.txt`.  
They are **off by default** and can be started on demand, keeping the system clean.

---

## 7. Ecosystem Scripts, Control Center & Audits

All orchestration and diagnostics are centralized in:

~/ecosystem-scripts/ ├── ai/ ├── crypto/ ├── ecosystem/ ├── security/ ├── dev/ └── nodes/

### 7.1 Control Center: ecosystem-menu.sh

The main entry point is:
~/ecosystem-scripts/ecosystem-menu.sh`

It provides a TUI Control Center with:

#### 1) AI / Agents – Checks, Install, Start

**Audits**
- `ai-agents-fullcheck.sh`
- `collectivai-agent-audit.sh`
- `privategpt-audit.sh`

**Live Status & Inventory**
- `ai-status-live.sh`
- `agents-bots-inventory.sh`

**Start**
- `start-all-agents.sh`
- `start-privategpt.sh`
- `start-metagpt.sh`

**Installers**
- `install-ai-agents.sh`
- `install-best-of-ki.sh`
- `install-models.sh`
- `install-optional-models.sh`

**Tests & Fixes**
- `test-all-agents.sh`
- `test-ollama-models.sh`
- `test-ollama-models-clean.sh`
- `test_autogen.py`
- `venv-opendevin-check.sh`
- `agent-hardfix.sh`
- `fix-all-agents.sh`
- `fix-metagpt.sh`

---

#### 2) Ecosystem – Master Check & Meta Audit

- `ecosystem-check.sh` – Master system + ecosystem check
- `ecosystem-meta-audit.sh` – Deep meta audit (basis for high-level reports)
- `ecosystem-livemon.sh` – Live monitoring (CLI & SwiftBar integration)

---

#### 3) Crypto / Blockchain – Nodes & Status

**Bitcoin**
- `btc-sync-status.sh`
- `btc-sync-monitor.sh`
- `btc-lightning-check.sh`

**Ethereum / Web3**
- `check-ethereum-node.sh`
- `check-eth-snap-sync.sh`
- `ethereum-suite-check.sh`
- `web3-suite-check.sh`

**Smart Contracts**
- `full-smartcontract-check.sh`

**Node Lifecycle**
- `start-all-crypto.sh`
- `start-geth-node.sh`
- `start-geth-repair.sh`

**Trading (prepared)**
- `trading-ai-check.sh`
- `trading-ai-finish-v2_1.sh`
- `trading-ai-fix.sh` and helpers

---

#### 4) Security / Blue Team – DNS & Watchdog

**DNSCrypt**
- `setup_dnscrypt.sh`
- `fix_dnscrypt.sh`
- `fix_dnscrypt_full.sh`
- `dnscrypt-reset.sh`

**Monitoring**
- `watchdog.sh`
- `sync-speed-check.sh`
- `swiftbar-cleanup.sh`

---

#### 5) GitHub / Dev – Status & Tools

- `github-status-check.sh` – Git & GitHub status
- `copilot-github-check.sh` – Copilot & dev tooling check
- `python-env-check.sh` – Python diagnostics
- `list-agents.sh`, `list-agent-dependencies.sh` – Dev view on agents
- `safe-update.sh` – Safe wrapper for system updates (brew, pipx, etc.)

---

#### 6) SwiftBar / Live Monitoring

- Integration with `ecosystem-livemon.sh`
- Quick access to the SwiftBar plugins directory
- Optionally opens the SwiftBar app

---

#### 7) Nodes / TAO / USB – Diagnostics

- `tao-diagnose.sh` – TAO/Bittensor diagnostics for the Ubuntu/UTM server
- `usb-ecosystem-setup.sh` – Prepare USB ecosystem media
- `usb-clone-utm-tao.sh` – Clone TAO UTM images onto USB

---

#### 8) List All Scripts by Category

- Shows a categorized overview of all scripts in `~/ecosystem-scripts/*`

---

#### 9) Home Inventory – Overview of `~/`

- Prints a structured inventory of the home directory:
  - AI, Ecosystem, Crypto, Nodes, Security, Dev, and standard macOS folders
- Confirms that scripts are centralized under `~/ecosystem-scripts/` and that `$HOME` itself is clean and organized.

The Control Center turns the Mac into a single-command ops console  
for AI, crypto, security, nodes, and diagnostics.

---

## 8. Role of This Mac in the CollectivAI Architecture

This MacBook Pro M2 Max is the central hub in a multi-node setup:

### macOS (this machine)

- Blue team, AI HQ, dashboards, orchestration & control
- PrivateGPT + Ollama local LLM stack
- Ecosystem scripts & SwiftBar monitoring

### UTM VMs

- Kali Linux – red team, pentesting, WiFi Pineapple, Alfa adapters
- Ubuntu Server – Bittensor (TAO) node(s) and additional services

### External Nodes

- Jetson / future GPU rigs for heavy AI & Bittensor workloads

The goal is a fully local, privacy-first, European-style AI & crypto environment  
with this Mac as the brain and control center.

---

## 8.1 Edge Nodes & Security Lab – Hackberry CM5

In addition to the macOS M2 Max lab, the CollectiVAI ecosystem uses  
two Hackberry CM5 boards as dedicated red/blue team nodes:

### Hardware

- 2 × Hackberry CM5
- 16 GB RAM
- 512 GB NVMe SSD
- 64 GB onboard flash (Compute Module 5)
- ~12 GB zram, ~32 GB swap each
- Integrated Wi-Fi & Bluetooth

### Operating Systems

- Kali Linux (Large) – red-team / offensive security lab
- Parrot OS (Security / Blue Team) – defensive analysis, monitoring, and hardening

### Wireless / Network Lab

- Hak5 WiFi Pineapple Mk7 Tactical – Wi-Fi auditing & attack simulation
- Alfa AWUS036ACM adapters – external USB Wi-Fi for Kali / Parrot

These nodes are used to:
- Simulate and analyze real-world attack scenarios (red team),
- Test and harden networks, Wi-Fi setups, and infrastructure (blue team),
- Validate that the CollectiVAI ecosystem can be deployed and defended  
  in realistic environments.

The macOS M2 Max acts as the central control plane, while the Hackberry CM5 boards provide a flexible, low-power security lab for continuous learning and testing.

---

## 9. Next Steps

Future improvements for this environment may include:

- Adding key scripts to the public repo:
  - `ecosystem-menu.sh`
  - `ecosystem-check.sh`
  - `ecosystem-meta-audit.sh`
  - `ecosystem-livemon.sh`
  - `github-status-check.sh`

- Adding architecture diagrams (Markdown / PlantUML / draw.io)
- Adding reproducibility docs (Homebrew Brewfile, central requirements.txt / pyproject.toml)
- Documenting SwiftBar plugins and dashboards

## 10. What this lab enables

This macOS M2 Max setup is not just a “nice dev machine” – it acts as a **mini data center** and **security lab** for CollectiVAI.

### 10.1 AI & Research Lab

- Run **100% local, offline-capable AI** with PrivateGPT + Ollama.
- Compare and benchmark different LLMs (chat, code, vision, reasoning, embeddings).
- Build and test **multi-agent workflows** (Autogen, CrewAI, Superagent, etc.).
- Use AI to assist with:
  - documentation & architecture design,
  - code review & refactoring,
  - knowledge base / retrieval experiments.

### 10.2 Blue-Team & Security Lab

- Validate firewall, VPN, Tor and DNS-over-Tor setups in a controlled environment.
- Run **security & leak checks** via dedicated shell scripts (LuLu, dnscrypt-proxy, Tor).
- Simulate blue-team workflows:
  - monitoring, logging, incident-style checks,
  - security baselines for macOS and Linux guests.
- Use the ecosystem menu as a **security cockpit** for the entire machine.

### 10.3 Red/Blue-Team Cyber Range (with external nodes)

Together with the Hackberry CM5 boards, Kali and Parrot OS, WiFi Pineapple Mk7 and Alfa WiFi adapters, this Mac acts as the **central command plane** for:

- Red-team experiments (Kali Large, WiFi auditing, network tests).
- Blue-team analysis (Parrot OS, monitoring, hardening).
- Realistic end-to-end scenarios where attacks, detection and defence are all under your control.

### 10.4 Blockchain, Nodes & DeFi Lab

- Operate a **Bitcoin Core full node** and **Ethereum Geth node** from one place.
- Develop and test **smart contracts** with Foundry, Hardhat, Brownie and testnets.
- Run **trading and strategy simulations** with Freqtrade, CCXT and related tools.
- Use shell scripts to:
  - inspect node health,
  - monitor sync status,
  - start/repair nodes with a single command.

### 10.5 Bots, Automation & Integrations

- Host a fleet of **social and messaging bots** (Telegram, Discord, Mastodon, X/Twitter, Matrix, etc.) in separate venvs.
- Connect bots to:
  - local LLMs (Ollama),
  - blockchain nodes,
  - ecosystem status scripts.
- Prototype **CollectiVAI-style assistants** that can:
  - fetch real node data,
  - call local tools,
  - provide human-friendly summaries and alerts.

### 10.6 Portfolio & Career Engine

This repository, together with the lab, is designed to:

- Show **real, running infrastructure**, not just theory.
- Demonstrate hands-on experience in:
  - AI infrastructure,
  - cybersecurity (red + blue),
  - blockchain & DeFi,
  - automation and DevOps-style scripting.
- Act as a **living portfolio** for roles in:
  - IT / system engineering,
  - cybersecurity / blue team,
  - AI / infrastructure engineering,
  - blockchain / Web3 infrastructure.

In short: this MacBook Pro is the **central brain** of the CollectiVAI ecosystem –  
a self-built AI, security and blockchain lab that can be inspected, extended and reused by others.
