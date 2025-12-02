<p align="center">
  <img src="logo.png" alt="CollectivAI Logo" width="400" />
</p>

# GitHub Status Check (macOS) – CollectivAI Ecosystem

This repository contains a small but powerful **diagnostic script** for macOS:

> `github-status-check.sh` – a one-shot health check for  
> Git, GitHub CLI, SSH keys, SSH agent, and GitHub authentication.

It is part of the wider **CollectivAI** ecosystem, running on a fully loaded  
MacBook Pro M2 Max used for AI, cybersecurity, crypto, and agent orchestration.

---

## 1. What the script does

The script is designed to answer one question:

> **“Am I 100% correctly connected to GitHub from this Mac?”**

It performs the following checks:

1. **Git installation**
   - Runs `git --version`
   - Warns if Git is missing

2. **GitHub CLI (`gh`)**
   - Runs `gh --version`
   - Reads the configured Git protocol for `github.com` (`ssh` or `https`)

3. **SSH keys in `~/.ssh`**
   - Lists existing public keys: `~/.ssh/id_*.pub`
   - Verifies presence of `id_ed25519.pub` (modern ED25519 key)

4. **SSH key fingerprint**
   - Prints the fingerprint of `~/.ssh/id_ed25519.pub` using `ssh-keygen -lf`

5. **SSH agent status**
   - Runs `ssh-add -l`
   - If the agent is running but has **no identities**, it automatically tries to load  
     `~/.ssh/id_ed25519` via  
     `ssh-add --apple-use-keychain ~/.ssh/id_ed25519`
   - Prints the final agent state

6. **GitHub SSH login test**
   - Runs: `ssh -T git@github.com`
   - Shows whether authentication works, e.g.:  
     `Hi collectiv-ai! You've successfully authenticated, but GitHub does not provide shell access.`

7. **GitHub CLI authentication status**
   - Runs: `gh auth status`
   - Shows:
     - active account (e.g. `collectiv-ai`)
     - protocol (`ssh`)
     - granted token scopes

8. **Clipboard helper**
   - Copies `~/.ssh/id_ed25519.pub` into the macOS clipboard via `pbcopy`
   - Useful to quickly paste the public key into GitHub → *Settings → SSH and GPG keys*

> 🔐 **Security note**  
> The script never prints **private keys** or tokens.  
> It only:
> - inspects local status,
> - prints fingerprints (public information),
> - and copies the **public key** into the clipboard.

---

## 2. Requirements

- macOS
- `git`
- [`gh` – GitHub CLI](https://cli.github.com/)
- `ssh`, `ssh-agent`, `ssh-add`
- `pbcopy` (standard on macOS)

---

## 3. Usage

Clone this repository and run:

```bash
# Make the script executable
chmod +x github-status-check.sh

# Run it
./github-status-check.sh
