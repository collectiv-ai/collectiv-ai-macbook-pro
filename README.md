<p align="center">
  <img src="logo.png" alt="CollectiVAI Logo" width="320" />
</p>

# CollectiVAI macOS Host

### macOS-based AI, security & crypto hub for the CollectiVAI ecosystem

[collectivai.org](https://collectivai.org) • MacBook Pro 16" – M2 Max, 64 GB RAM, 2 TB SSD • Made in Europe 🇪🇺

* * *

## Overview

The CollectiVAI macOS Host is the **primary workstation and control plane**  
for the broader CollectiVAI ecosystem.

It is used as a:

- **blue-team & AI hub** (local LLMs, agents, orchestration),
- **security & privacy anchor** (VPN, Tor, DNS-over-Tor, firewall),
- **crypto & blockchain lab** (Bitcoin, Ethereum, smart contracts),
- and **dev machine** for the App, Router, Chain and agents.

This repository documents the **software stack, roles and structure** of the macOS host,  
and can serve as a reference for reproducing a similar setup.

* * *

## Design goals

The macOS host is designed around a few simple principles:

1. Human-centred & privacy-first

   - Local-first AI wherever possible (Ollama, local agents, local data).
   - Minimal external dependencies; remote APIs only where needed.
   - Tor, VPN and DNS-hardening to keep network activity under control.

2. Transparent & auditable

   - Diagnostic scripts (deep audits, live monitors, GitHub checks).
   - Clear separation of concerns: AI, security, blockchain, social bots.
   - Prefer plain text (shell, Markdown, logs) for long-term understanding.

3. Modular & extensible

   - Each major component (agents, bots, nodes) in its **own directory & venv**.
   - `pipx` for isolated global tools (CLI apps, dashboards).
   - Easy to add or remove modules without breaking the core system.

4. Realistic but safe experimentation

   - Full Bitcoin/Ethereum stack for testing and education.
   - No speculative “quick money” focus – instead: infrastructure & governance.
   - Agents and bots are treated as tools, not as autonomous black boxes.

5. Europe-focused, globally usable

   - Built in the spirit of European digital sovereignty and democratic AI.
   - Documentation and structure are generic enough to be adapted elsewhere.

* * *

## Host structure (high level)

A possible layout for this repo and related directories:

```text
collectiv-ai-macos-host/
├─ docs/                 # High-level documentation (this README, diagrams, notes)
├─ scripts/              # System & ecosystem scripts (audit, monitoring, checks)
│  ├─ ecosystem-deepaudit.sh
│  ├─ ecosystem-livemon.sh
│  ├─ github-status-check.sh
│  └─ ...
├─ ai/
│  ├─ ollama/            # Model zoo configuration & notes
│  ├─ privategpt/        # Local RAG / private GPT setups
│  └─ tools/             # Helper scripts for AI workflows
├─ agents/
│  ├─ telegram-bot/
│  ├─ discord-bot/
│  ├─ trading-bot/
│  ├─ github-bot/
│  └─ ...
├─ crypto/
│  ├─ bitcoin/           # bitcoind, configs, helper scripts
│  ├─ ethereum/          # geth, solidity, foundry, hardhat
│  └─ tools/             # CLI utilities, monitoring
├─ security/
│  ├─ tor/
│  ├─ vpn/
│  ├─ dns/
│  └─ firewall/
└─ system/
   ├─ swiftbar/          # Menu bar plugins & dashboards
   └─ autostart/         # Launch agents, watch dogs
