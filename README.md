<p align="center">
  <img src="logo.png" alt="CollectivAI Logo" width="400" />
</p>

# CollectivAI – macOS M2 Max Ecosystem Overview

This repository documents the **full local ecosystem** running on a  
**MacBook Pro 16" – Apple M2 Max, 12 CPU, 38 GPU64, 64GB RAM, 2 TB SSD (macOS 26.x)**.

It is the primary **blue-team / AI / orchestration machine** in the wider  
**CollectivAI** environment (macOS + Kali + Ubuntu/Bittensor + nodes & agents).

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
- RAM heavily used by AI/agents, still enough headroom for concurrent workloads  [oai_citation:1‡Gesicherte Terminal-Ausgabe.txt](sediment://file_000000002880720eb66f0d9a4cc929ae)  

---

## 2. Python & Environments

The Mac acts as a **Python hub** for AI, agents, bots and trading systems.

### 2.1 Global Python

- Primary Python: **Python 3.13.x** (Homebrew installation)
- Thousands of packages installed globally, including (selection):  [oai_citation:2‡Gesicherte Terminal-Ausgabe.txt](sediment://file_000000002880720eb66f0d9a4cc929ae)  
  - **AI / LLM & tooling**  
    - `openai`, `anthropic`, `google-genai`, `litellm`, `llama-index*`, `langchain*`, `llama-parse`, `jupyterlab`
  - **Web / APIs / frameworks**  
    - `fastapi`, `uvicorn`, `Flask`, `gradio`, `streamlit`, `websockets`, `httpx`, `requests`
  - **Data & science**  
    - `pandas`, `numpy`, `scipy`, `matplotlib`, `scikit-learn`, `statsmodels`
  - **Crypto / blockchain**  
    - `web3`, `eth-account`, `ccxt`, `freqtrade`, `tronpy`, `Riskfolio-Lib`
  - **Agent & automation frameworks**  
    - `autogen`, `autogen-agentchat`, `autogen-core`, `crewai`, `deepeval`, `open-interpreter`
  - **Observability / telemetry**  
    - OpenTelemetry stack (`opentelemetry-*`)

> The global Python environment is intentionally **rich**, as this Mac is the  
> central lab for testing AI agents, orchestration, trading bots and infra.

### 2.2 pipx Apps

`pipx` is used to isolate complex tools into separate venvs. Examples:  [oai_citation:3‡Gesicherte Terminal-Ausgabe.txt](sediment://file_000000002880720eb66f0d9a4cc929ae)  

- `aider-chat`, `autogenstudio`, `chromadb`, `crewai`, `cryptoadvance-specter`
- `freqtrade`, `glances`, `gpt-engineer`
- `jupyterlab`, `langchain-cli`, `langgraph-cli`
- `open-interpreter`, `open-webui`, `poetry`, `streamlit`

Each of these runs in its own virtual environment under `~/.local/pipx/venvs`.

### 2.3 Agent & Bot Environments

Under `~/ai-agents/` there is a **full fleet of dedicated virtualenvs**:  [oai_citation:4‡Gesicherte Terminal-Ausgabe.txt](sediment://file_000000002880720eb66f0d9a4cc929ae)  

- `autogenstudio`, `crewai`, `openai-bot`, `ai-bot`, `open-interpreter`
- Social / comms bots:
  - `telegram-bot`, `telegram-broadcast-hub`, `discord-bot`, `slack-bot`,  
    `mastodon-bot`, `matrix-bot`, `twitter-bot`, `reddit-bot`, `linkedin-bot`
- Trading & crypto:
  - `hummingbot`, `trading-bot`, `ccxt-bot`, `jesse`, `freqtrade`
- Agent frameworks:
  - `superagent`, `agent-llm`, `metagpt`, `opendevin` (attached inside `superagent`)
- Tools / utilities:
  - `tools`, `voice-bot`, `whisper-bot`, `github-bot`, `lc-li`

Each subproject has its own `requirements.txt` and venv, allowing **clean isolation**.

---

## 3. Local LLM Stack (Ollama)

The Mac hosts a **large Ollama model zoo** optimised for different tasks:  [oai_citation:5‡Gesicherte Terminal-Ausgabe.txt](sediment://file_000000002880720eb66f0d9a4cc929ae)  

Examples (subset):

- **General / chat / reasoning**
  - `llama3.1:8b`, `llama3:latest`, `mistral:latest`, `neural-chat:latest`, `openchat:latest`
  - `zephyr:latest`, `vicuna:latest`, `openhermes:latest`, `nous-hermes2:latest`
- **Code-focused**
  - `deepseek-coder-v2:16b`, `deepseek-coder:6.7b`
  - `qwen2.5-coder:7b` & `14b`
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

> This enables **local-only**, privacy-preserving AI for:
> - agents,  
> - bots,  
> - code assistants,  
> - retrieval workflows,  
> - and experiment setups.

---

## 4. Blockchain & Crypto Infrastructure

The Mac also functions as a **full crypto & smart contract lab**:  [oai_citation:6‡Gesicherte Terminal-Ausgabe.txt](sediment://file_000000002880720eb66f0d9a4cc929ae)  

- **Bitcoin**
  - `bitcoind` – Bitcoin Core v30.0.0 (full node)
  - `bitcoin-cli` used for node inspection and tooling
  - (At the time of the snapshot, RPC was not reachable → node not running)
- **Ethereum & EVM**
  - `geth` – Go Ethereum 1.16.x
  - `solc` – Solidity compiler
  - `forge` / `cast` / `anvil` – Foundry toolchain
  - `hardhat` – smart contract dev / testing framework
  - `eth-brownie` – Python-based Ethereum dev framework
- **Trading & Bots**
  - `freqtrade`, `ccxt`, `jesse`, `backtrader`  
  - Used for research, strategy testing and agent-integrated trading simulations

The idea: **one macOS machine** as a **unified AI + blockchain research node**.

---

## 5. Security, Networking & Privacy

Security and privacy are treated as **first-class citizens**.  [oai_citation:7‡Gesicherte Terminal-Ausgabe.txt](sediment://file_000000002880720eb66f0d9a4cc929ae)  

- **Firewall**
  - LuLu firewall: **active** and running
- **VPN**
  - VPN interface (`utun*`) active – used for anonymisation & geo abstraction
- **Tor**
  - System-level `tor` service running on `127.0.0.1:9050`
  - Integrated with other tools (DNS, agents, VPN stack)
- **DNS / leak protection**
  - DNS-over-Tor + dnscrypt-proxy (separate tooling, not detailed in this snapshot)
- **Security tools**
  - `crowdsec`, `fail2ban` installed (inactive in this snapshot)
- **Exposed local services**
  - `ollama` listening on `127.0.0.1:11434` (plus IPv6)
  - `tor` listening on `127.0.0.1:9050`

---

## 6. Bots & Social Integrations

Several **social and messaging bots** are wired into the environment  
(each with its own venv + `requirements.txt`):  [oai_citation:8‡Gesicherte Terminal-Ausgabe.txt](sediment://file_000000002880720eb66f0d9a4cc929ae)  

- Telegram, Discord, Slack, Mastodon, Reddit, Matrix, Twitter/X, LinkedIn
- Mail bots (IMAP/SMTP), GitHub bot, Whisper-based voice bot

In the snapshot, most of them are **inactive** (designed to be launched on demand  
or via custom supervisor scripts), which keeps the system clean and controlled.

---

## 7. Ecosystem Scripts & Audits

The Mac uses multiple **diagnostic and orchestration scripts**, e.g.:

- `ecosystem-deepaudit.sh` – full system & ecosystem dump (the basis for this README)
- `ecosystem-livemon.sh` – live monitoring via terminal / SwiftBar
- `github-status-check.sh` – checks Git, GitHub CLI, SSH keys/agent & auth
- Additional scripts for:
  - AI ecosystem checks
  - Blockchain node monitoring
  - Autostart & watchdog logic
  - SwiftBar menu integration

These scripts make the system **transparent, reproducible and debuggable**.

---

## 8. Role of This Mac in the CollectivAI Architecture

This MacBook Pro M2 Max is the **central hub** in a multi-node setup:

- macOS: **Blue team**, AI HQ, dashboards, orchestration
- UTM VMs:
  - Kali Linux: red-team, pentesting, WiFi (Pineapple, Alfa, etc.)
  - Ubuntu Server: Bittensor (TAO) node(s), additional services
- External nodes:
  - Jetson / future GPU rigs for heavy AI & mining workloads

The goal is a **fully local, privacy-first, European-style AI & crypto environment**,  
with this Mac as the **brain and control center**.

---

## 9. Notes & Next Steps

Possible future extensions for this repository:

- Add the main scripts:
  - `ecosystem-deepaudit.sh`
  - `ecosystem-livemon.sh`
  - `github-status-check.sh`
- Add architecture diagrams (markdown / draw.io / images)
- Add a reproducibility section:
  - Homebrew bundle file
  - `requirements.txt` / `pyproject.toml` for key components
- Document SwiftBar plugins and status dashboards

---

## License

You can choose any license, e.g.:

```text
MIT License – see LICENSE file.
