<p align="center">
  <img src="logo.png" alt="CollectivAI Logo" width="400" />
</p>

# CollectiVAI – macOS M2 Max Ecosystem Overview

This repository documents the **full local ecosystem** running on a  
**MacBook Pro 16" – Apple M2 Max, 64 GB RAM, 2 TB SSD (macOS 26.x)**.

It is the primary **blue-team / AI / orchestration machine** in the wider  
**CollectivAI** environment (macOS + Kali + Ubuntu/Bittensor + nodes & agents).

The focus of this setup is:

- **100% local & offline capable AI** (PrivateGPT + Ollama)
- Deep integration of **AI + blockchain + security tooling**
- A clean, script-driven **Control Center** for daily operations

---

## 1. Host System

**Hardware**

- Device: MacBook Pro 16"
- SoC: Apple M2 Max
- RAM: 64 GB
- Internal SSD: 2 TB  
- Main OS: macOS 26.1 (Darwin 26.x)

**Runtime Snapshot**

- macOS 26.1, build 25B78  
- Plenty of free disk space on `/`  
- RAM heavily used by AI/agents, still enough headroom for concurrent workloads  

The machine is designed as a **permanent lab & control plane**, not a minimal install.

---

## 2. Python & Environments

The Mac acts as a **Python hub** for AI, agents, bots and trading systems.

### 2.1 Global Python

- Primary Python: **Python 3.13.x** (Homebrew)
- A rich global environment with thousands of packages, including:

**AI / LLM & tooling**

- `openai`, `anthropic`, `google-genai`, `litellm`  
- `llama-index*`, `langchain*`, `llama-parse`  
- `jupyter`, `jupyterlab`

**Web / APIs / frameworks**

- `fastapi`, `uvicorn`, `Flask`, `gradio`, `streamlit`  
- `websockets`, `httpx`, `requests`

**Data & science**

- `pandas`, `numpy`, `scipy`, `matplotlib`, `scikit-learn`, `statsmodels`

**Crypto / blockchain**

- `web3`, `eth-account`, `ccxt`, `freqtrade`, `tronpy`, `Riskfolio-Lib`

**Agent & automation frameworks**

- `autogen`, `autogen-agentchat`, `autogen-core`  
- `crewai`, `deepeval`, `open-interpreter`

**Observability / telemetry**

- OpenTelemetry stack (`opentelemetry-*`)

> The global environment is intentionally **rich** – this Mac is the main lab for AI agents, orchestration, trading bots and infra.

### 2.2 pipx Apps

`pipx` is used to isolate complex tools into dedicated venvs, such as:

- `aider-chat`, `autogenstudio`, `chromadb`, `crewai`
- `cryptoadvance-specter`, `freqtrade`, `glances`, `gpt-engineer`
- `jupyterlab`, `langchain-cli`, `langgraph-cli`
- `open-interpreter`, `open-webui`, `poetry`, `streamlit`

All live under `~/.local/pipx/venvs`, fully separated from system Python.

### 2.3 Agent & Bot Environments

Under `~/ai-agents/` there is a **full fleet of agent and bot environments**:

- **Agent frameworks & tools**  
  `autogenstudio`, `crewai`, `openai-bot`, `ai-bot`,  
  `open-interpreter`, `superagent`, `agent-llm`, `metagpt`, `opendevin`

- **Social / comms bots**  
  `telegram-bot`, `telegram-broadcast-hub`, `discord-bot`, `slack-bot`,  
  `mastodon-bot`, `matrix-bot`, `twitter-bot`, `reddit-bot`, `linkedin-bot`

- **Trading & crypto**  
  `hummingbot`, `trading-bot`, `ccxt-bot`, `jesse`, `freqtrade`

- **Utilities / glue**  
  `tools`, `voice-bot`, `whisper-bot`, `github-bot`, `lc-li`

Each subproject has its own `requirements.txt` and venv, allowing **clean isolation**.

---

## 3. Local LLM Stack (Ollama + PrivateGPT)

The system uses a **local-only LLM stack**:

- **Ollama** as the main model server (`ollama serve` on `127.0.0.1:11434`)
- **PrivateGPT** (in `~/AI/private-gpt`) configured to talk to Ollama  
  → **no OpenAI / cloud LLM dependency**

PrivateGPT is started via a wrapper script (e.g. `pgpt-ollama.sh`) that selects an Ollama model like:

- `llama3.1:8b` as the main general-purpose model

A subset of the Ollama model zoo:

**General / chat / reasoning**

- `llama3.1:8b`, `llama3:latest`, `mistral:latest`, `neural-chat:latest`, `openchat:latest`  
- `zephyr:latest`, `vicuna:latest`, `openhermes:latest`, `nous-hermes2:latest`

**Code-focused**

- `deepseek-coder-v2:16b`, `deepseek-coder:6.7b`  
- `qwen2.5-coder:7b`, `qwen2.5-coder:14b`  
- `codellama:latest`, `codellama:13b-instruct`  
- `codestral:latest`, `sqlcoder:7b`

**Vision & multimodal**

- `llava:latest`, `llava:13b`, `llava:34b`  
- `bakllava:latest`, `moondream:latest`

**Reasoning / R1-style**

- `deepseek-r1:7b`, `deepseek-r1:14b`

**Embedding / retrieval**

- `nomic-embed-text:latest`, `mxbai-embed-large:latest`, `bge-m3:latest`

**Lightweight / experimental**

- `tinyllama:latest`, `gemma:2b`, `phi3:mini`, `phi3:medium`

> The entire LLM pipeline runs **locally and offline**.  
> PrivateGPT + Ollama provide a self-contained, privacy-first AI stack.

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
- `hardhat` – JS-based smart contract framework
- `eth-brownie` – Python-based Ethereum dev stack

### 4.3 Trading & Bots

- `freqtrade`, `ccxt`, `jesse`, `backtrader` and others
- Used for strategy research and AI-assisted trading simulations

> Design goal: one macOS machine as a unified **AI + blockchain research node**.

---

## 5. Security, Networking & Privacy

Security and privacy are **first-class citizens** in this setup.

- **Firewall**
  - LuLu firewall: **active** and monitoring outbound connections

- **VPN**
  - VPN interface (`utun*`) active – used for anonymisation & geo abstraction

- **Tor**
  - System-level `tor` service on `127.0.0.1:9050`
  - Integrated into the DNS stack and can be used by agents & CLI tools

- **DNS / leak protection**
  - DNS-over-Tor with `dnscrypt-proxy`  
  - Dedicated scripts to configure, fix and reset dnscrypt and prevent DNS leaks

- **Security tools**
  - `crowdsec`, `fail2ban` installed (can be enabled when needed)

- **Exposed local services**
  - `ollama` on `127.0.0.1:11434` (+ IPv6)  
  - `tor` on `127.0.0.1:9050`

---

## 6. Bots & Social Integrations

Several **social and messaging bots** are integrated:

- Telegram, Discord, Slack, Mastodon, Reddit, Matrix, Twitter/X, LinkedIn
- Mail bots (IMAP/SMTP), GitHub bot, Whisper-based voice bot

All live under `~/ai-agents/` in separate venvs with `requirements.txt`.  
They are **off by default** and can be started on demand, keeping the system clean.

---

## 7. Ecosystem Scripts, Control Center & Audits

All orchestration and diagnostics are centralized in:

```text
~/ecosystem-scripts/
  ├── ai/
  ├── crypto/
  ├── ecosystem/
  ├── security/
  ├── dev/
  └── nodes/
