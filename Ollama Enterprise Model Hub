# CollectivAI – Enterprise Ollama Stack (M2 Max, 64 GB RAM)

> **Status:** Production-ready local model hub  
> **Host:** MacBook Pro M2 Max, 64 GB RAM, macOS 26.x  
> **Stack:** Ollama + Local Models + Cloud Backends

This repository documents the **CollectivAI Enterprise LLM Stack** running locally on a  
MacBook Pro **M2 Max (64 GB RAM)** using **Ollama** as the model runtime.

The goal of this setup is:

- A **single machine** that can act as an **Enterprise LLM Hub**
- Cover **all major capability domains**:
  - General chat & reasoning
  - Coding & DevOps & Smart Contracts
  - Cybersecurity (Red & Blue Team)
  - Math & formal reasoning
  - Vision (screenshots, GUIs, diagrams)
  - Audio (ASR)
  - RAG / Embeddings
  - Lightweight / routing models
- Combine **local models** with a few **high‑end cloud backends** (Qwen3, DeepSeek, Mistral, GPT‑OSS).

---

## 1. Hardware & Runtime

- **Host:** MacBook Pro 16" – Apple M2 Max  
- **RAM:** 64 GB  
- **OS:** macOS 26.x  
- **Runtime:** [Ollama](https://ollama.com) (`ollama --version` ≈ 0.13.x)

This stack is tuned so that **multiple models** can be active in parallel, but the  
system still remains usable for development, security tooling and nodes.

---

## 2. Model Overview (Local)

### 2.1 General / Chat / Orchestrator Models

These are the main “brains” for general tasks, planning and system orchestration.

- `llama3.1:latest` – primary general assistant (Meta Llama 3.1)
- `llama3:latest` – additional Llama 3 family slot
- `mixtral:latest` – Mixture-of-Experts, strong reasoning, great for security & complex tasks
- `qwen3:14b`, `qwen3:8b` – modern Qwen3 family (multi‑language, strong reasoning)
- `gemma3:27b`, `gemma3:12b` – latest Google Gemma family
- `gemma2:27b`, `gemma2:9b` – previous Gemma generation (kept for comparison / fallbacks)
- `yi:34b`, `yi:9b` – strong Chinese/English family, excellent for engineering & security
- `mistral:latest` – compact general LLM, good baseline
- `zephyr:latest` – helpful / aligned chat model
- `neural-chat:latest`, `openchat:latest` – chat‑optimized alternatives
- `command-r:latest`, `command-r7b:latest` – good “agent‑style” orchestration models
- `gpt-oss:20b` – open GPT‑style baseline

### 2.2 Reasoning / Math / Formal Proof

- `qwen2-math:7b` – math specialist (step‑by‑step, exam-style)
- `Hudson/llemma:7b` – math & formal proof / paper reasoning
- `deepseek-r1:7b`, `deepseek-r1:14b` – reasoning‑oriented models
- plus strong general reasoners: `mixtral:latest`, `yi:34b`, `llama3.1:latest`

### 2.3 Coding / Dev / Smart Contracts

- `qwen2.5:32b`, `qwen2.5:14b`, `qwen2.5:7b` – strong general & code‑capable LLMs
- `qwen2.5-coder:14b` – primary coding model (Python, JS, Rust, Solidity, …)
- `deepseek-coder-v2:16b` – deep code reasoning & refactors
- `starcoder2:15b` – classic code LLM for multi‑language codebases
- `codestral:latest` – great for DevOps, infra, shell & backend
- `sqlcoder:7b` – SQL specialist
- `devstral:latest` – agentic coding model, well‑suited for multi‑step dev flows

### 2.4 Vision / Multimodal

- `llava:34b` – heavy‑duty vision model (screenshots, GUIs, diagrams, plots)
- `moondream:latest` – lightweight vision model (small images, icons, snippets)

Example uses:

- Analyse screenshots (SwiftBar, dashboards, UIs)
- Understand diagrams / network maps
- Read text from images

### 2.5 Audio (ASR – Speech to Text)

- `karanchopda333/whisper:latest` – high‑quality Whisper ASR
- `dimavz/whisper-tiny:latest` – ultra‑fast, resource‑light ASR

These are used for **voice input**.  
Text‑to‑speech (TTS) is handled outside of Ollama (e.g. macOS `say`, Piper, Coqui, etc.).

### 2.6 Embeddings / RAG

- `nomic-embed-text:latest` – general embeddings (docs, notes, logs)
- `mxbai-embed-large:latest` – high‑end embeddings for large knowledge bases
- `bge-m3:latest` – versatile, multilingual / multi‑granularity embeddings
- `snowflake-arctic-embed:335m` – embeddings for data/analytics style content

These power:

- PrivateGPT / RAG flows  
- Documentation & repo search  
- Log / incident search  
- Enterprise knowledge hubs

### 2.7 Lightweight / Routing / Edge‑Style

- `phi3:mini` – small, fast LLM for classification & routing
- `smollm2:1.7b` – ultra‑compact general model

Typical usage:

- Decide which specialist model to call (“router”)
- Quick classification / tagging
- Edge‑style microservices

---

## 3. Cloud Backends (Ollama Cloud Models)

In addition to local models, this stack uses several powerful **cloud models** via Ollama:

- `qwen3-vl:235b-cloud` / `qwen3-vl:235b-instruct-cloud` – high‑end multimodal VL models
- `qwen3-coder:480b-cloud` – massive coding model
- `deepseek-v3.1:671b-cloud` – very strong reasoning/generalist model
- `mistral-large-3:675b-cloud` – top‑tier Mistral model
- `gpt-oss:20b-cloud`, `gpt-oss:120b-cloud` – GPT‑like OSS backends
- `ministral-3:14b-cloud`, `ministral-3:8b-cloud`, `ministral-3:3b-cloud` – smaller Mistral‑style cloud models

These are only used when:

- Contexts are very large  
- Quality trumps latency  
- Tasks need “beyond local” capacity (e.g. complex legal writing, huge reports, etc.)

---

## 4. Task → Model Map

This section documents a suggested routing for common tasks.

### 4.1 General Chat / System Assistant

- **Primary local:**
  - `llama3.1:latest`
- **Alternative local:**
  - `mixtral:latest`
  - `qwen3:14b`
  - `gemma3:27b`
- **Cloud fallback:**
  - `mistral-large-3:675b-cloud`
  - `deepseek-v3.1:671b-cloud`

### 4.2 Coding / DevOps / Smart Contracts

- **Primary:**
  - `qwen2.5-coder:14b`
- **Secondary / deep reasoning:**
  - `deepseek-coder-v2:16b`
  - `devstral:latest`
- **Classic baseline:**
  - `starcoder2:15b`
  - `codestral:latest`
- **SQL:**
  - `sqlcoder:7b`
- **Cloud fallback:**
  - `qwen3-coder:480b-cloud`

### 4.3 Cybersecurity (Red & Blue Team)

- **Analysis / strategy / playbooks:**
  - `mixtral:latest`
  - `yi:34b`
- **Code for tools & scripts:**
  - `qwen2.5-coder:14b`
  - `deepseek-coder-v2:16b`
- **Cloud escalation:**
  - `deepseek-v3.1:671b-cloud`

### 4.4 Math / Formal Reasoning

- **Math specialist:**
  - `qwen2-math:7b`
- **Proof / paper‑style:**
  - `Hudson/llemma:7b`
- **Alt. general reasoners:**
  - `mixtral:latest`
  - `yi:34b`
- **Cloud fallback:**
  - `deepseek-v3.1:671b-cloud`

### 4.5 Vision / Screenshots / Diagrams

- **Local heavy:**
  - `llava:34b`
- **Local light:**
  - `moondream:latest`
- **Cloud heavy:**
  - `qwen3-vl:235b-instruct-cloud`

### 4.6 Audio / Voice

- **ASR (speech → text):**
  - `karanchopda333/whisper:latest`
  - `dimavz/whisper-tiny:latest`
- **TTS (text → speech):**
  - handled by external tools (e.g. macOS `say`)

### 4.7 RAG / Knowledge / Search

- **General/doc embeddings:**
  - `nomic-embed-text:latest`
- **Large knowledge base / high quality:**
  - `mxbai-embed-large:latest`
- **Multilingual:**
  - `bge-m3:latest`
- **Data/analytics‑style:**
  - `snowflake-arctic-embed:335m`

---

## 5. Example: Model Routing Concept

In a real application (e.g. CollectivAI Control Center / API), requests can be routed:

```text
User task → Router model (phi3:mini / smollm2:1.7b)
          → Category (chat / code / security / math / vision / rag / audio)
          → Best local model (with optional cloud fallback)
```

For example:

- “Schreib mir einen Python-Script für Bitcoin-Node-Monitoring”  
  → Router → `code` → `qwen2.5-coder:14b`

- “Analysiere diesen Log eines Firewallsystems”  
  → Router → `security` → `mixtral:latest` (+ evtl. `qwen2.5-coder:14b` für Skriptvorschläge)

- “Beweise, dass die Summe zweier gerader Zahlen wieder gerade ist”  
  → Router → `math` → `Hudson/llemma:7b`

- “Transkribiere dieses Audio in Deutsch”  
  → Router → `audio` → `whisper` model

- “Suche in meinen Logs nach allen SSH‑Fehlern und fasse sie zusammen”  
  → Router → `rag` → embeddings + `llama3.1:latest` für die Antwort

---

## 6. Installation & Usage (High Level)

### 6.1 Prerequisites

- Install [Ollama](https://ollama.com)
- Ensure enough disk space (many models are multi‑GB)
- Recommended: at least 64 GB RAM for comfortable parallel use

### 6.2 Pulling Models

Pull a model (example):

```bash
ollama pull llama3.1:latest
ollama pull mixtral:latest
ollama pull qwen2.5-coder:14b
```

Check installed models:

```bash
ollama list
```

Run a model:

```bash
ollama run llama3.1:latest
```

---

## 7. License & Notes

- This repository documents a **local model stack** managed via Ollama.  
- Individual models have their own licenses from their respective providers  
  (Meta, Google, Alibaba, Mistral, Snowflake, DeepSeek, etc.).  
- Always check licensing and allowed use (commercial / non‑commercial)  
  before deploying models in production.

---

**Maintainer:**  
CollectivAI – Democratic AI for Europe  
(Used as a local Enterprise LLM Hub on macOS M2 Max)
