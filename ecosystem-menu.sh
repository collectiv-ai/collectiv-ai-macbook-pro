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
- **Deep integration of AI + blockchain + security tooling**
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

The machine is designed as a **permanent lab & control plane** rather than a minimal workstation.

---

## 2. Python & Environments

The Mac acts as a **Python hub** for AI, agents, bots and trading systems.

### 2.1 Global Python

- Primary Python: **Python 3.13.x** (Homebrew installation)
- A rich global environment with thousands of packages, including (selection):  

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

> The global Python environment is intentionally **rich**, as this Mac is the  
> central lab for testing AI agents, orchestration, trading bots and infra.

### 2.2 pipx Apps

`pipx` is used to isolate complex tools into separate venvs, for example:

- `aider-chat`, `autogenstudio`, `chromadb`, `crewai`
- `cryptoadvance-specter`, `freqtrade`, `glances`, `gpt-engineer`
- `jupyterlab`, `langchain-cli`, `langgraph-cli`
- `open-interpreter`, `open-webui`, `poetry`, `streamlit`

Each of these runs in its own virtual environment under `~/.local/pipx/venvs`.

### 2.3 Agent & Bot Environments

Under `~/ai-agents/` there is a **full fleet of dedicated virtualenvs**:  

- Agent frameworks & tools:  
  `autogenstudio`, `crewai`, `openai-bot`, `ai-bot`, `open-interpreter`, `superagent`, `agent-llm`, `metagpt`, `opendevin` (inside `superagent`)

- Social / comms bots:  
  `telegram-bot`, `telegram-broadcast-hub`, `discord-bot`, `slack-bot`,  
  `mastodon-bot`, `matrix-bot`, `twitter-bot`, `reddit-bot`, `linkedin-bot`

- Trading & crypto:  
  `hummingbot`, `trading-bot`, `ccxt-bot`, `jesse`, `freqtrade`

- Utilities / glue:  
  `tools`, `voice-bot`, `whisper-bot`, `github-bot`, `lc-li`

Each subproject has its own `requirements.txt` and venv, allowing **clean isolation** and controlled activation.

---

## 3. Local LLM Stack (Ollama + PrivateGPT)

The Mac hosts a **local-only LLM stack**, with:

- **Ollama** as the main model server (`ollama serve` on `127.0.0.1:11434`)
- **PrivateGPT** configured to talk to Ollama (no OpenAI or external API dependency)

PrivateGPT runs in its own Python virtualenv under `~/AI/private-gpt` and uses a wrapper script (e.g. `pgpt-ollama.sh`) to start with a chosen Ollama model such as:

- `llama3.1:8b` (primary general-purpose model)
- plus other models available via `ollama list`

The Ollama model zoo (subset) includes:

- **General / chat / reasoning**
  - `llama3.1:8b`, `llama3:latest`, `mistral:latest`, `neural-chat:latest`, `openchat:latest`
  - `zephyr:latest`, `vicuna:latest`, `openhermes:latest`, `nous-hermes2:latest`

- **Code-focused**
  - `deepseek-coder-v2:16b`, `deepseek-coder:6.7b`
  - `qwen2.5-coder:7b`, `qwen2.5-coder:14b`
  - `codellama:latest`, `codellama:13b-instruct`
  - `codestral:latest`, `sqlcoder:7b`

- **Vision & multimodal**
  - `llava:latest`, `llava:13b`, `llava:34b`
  - `bakllava:latest`, `moondream:latest`

- **Reasoning / R1-style**
  - `deepseek-r1:7b`, `deepseek-r1:14b`

- **Embedding / retrieval**
  - `nomic-embed-text:latest`, `mxbai-embed-large:latest`, `bge-m3:latest`

- **Lightweight / experimental**
  - `tinyllama:latest`, `gemma:2b`, `phi3:mini`, `phi3:medium`

> The entire LLM pipeline runs **locally and offline**.  
> No OpenAI or cloud LLM access is required for the core workflows.

---

## 4. Blockchain & Crypto Infrastructure

The Mac also functions as a **full crypto & smart contract lab**:

**Bitcoin**

- `bitcoind` – Bitcoin Core v30.0.0 (full node)
- `bitcoin-cli` – RPC & on-chain tooling
- Additional helper scripts (see Section 7) to monitor sync and health

**Ethereum & EVM**

- `geth` – Go Ethereum 1.16.x
- `solc` – Solidity compiler
- `forge` / `cast` / `anvil` – Foundry toolchain
- `hardhat` – JavaScript-based smart contract dev/testing
- `eth-brownie` – Python-based Ethereum framework

**Trading & Bots**

- `freqtrade`, `ccxt`, `jesse`, `backtrader` and others
- Used for strategy research & AI-assisted trading experiments

The design goal: **one macOS machine** as a unified **AI + blockchain research node**.

---

## 5. Security, Networking & Privacy

Security and privacy are treated as **first-class citizens**.

- **Firewall**
  - LuLu firewall: **active** and running

- **VPN**
  - VPN interface (`utun*`) active – used for anonymisation & geo abstraction

- **Tor**
  - System-level `tor` service running on `127.0.0.1:9050`
  - Integrated with other tools (DNS, agents, VPN stack)

- **DNS / leak protection**
  - DNS-over-Tor + `dnscrypt-proxy` (configured and maintained by dedicated scripts)
  - Focus on preventing DNS leaks, especially during Tor/VPN usage

- **Security tools**
  - `crowdsec`, `fail2ban` installed (can be activated when needed)

- **Exposed local services**
  - `ollama` listening on `127.0.0.1:11434` (and IPv6)
  - `tor` listening on `127.0.0.1:9050`

---

## 6. Bots & Social Integrations

Several **social and messaging bots** are wired into the environment, each with its own venv + `requirements.txt` under `~/ai-agents/`:

- Telegram, Discord, Slack, Mastodon, Reddit, Matrix, Twitter/X, LinkedIn
- Mail bots (IMAP/SMTP), GitHub bot, Whisper-based voice bot

Most of them are **inactive by default** and are designed to be launched on demand or via supervisor / orchestration scripts, keeping the system tidy and under control.

---

## 7. Ecosystem Scripts, Control Center & Audits

All orchestration and diagnostics are centralized under:

```text
~/ecosystem-scripts/
  ├── ai/
  ├── crypto/
  ├── ecosystem/
  ├── security/
  ├── dev/
  └── nodes/
