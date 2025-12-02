# GitHub Status Check (macOS)

Small diagnostic script for macOS that checks:

- git installation
- GitHub CLI (gh) installation and protocol (ssh/https)
- presence of SSH keys (~/.ssh/id_ed25519.pub)
- SSH agent status
- SSH login to GitHub (git@github.com)
- GitHub CLI authentication status
- copies id_ed25519.pub to the clipboard for easy upload

> ⚠️ Note: This script prints your local username, home directory,
> hostname and SSH key fingerprints. It does **not** expose any private keys
> or tokens.
