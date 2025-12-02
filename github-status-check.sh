#!/bin/bash

echo "---- GITHUB SYSTEM CHECK (macOS) ----"
echo "User:    $(whoami)"
echo "Home:    $HOME"
echo "Hostname: $(hostname)"
echo ""

echo "1️⃣  GIT version:"
if command -v git >/dev/null 2>&1; then
  git --version
else
  echo "❌ git not found (install Xcode Command Line Tools or Homebrew git)."
fi

echo ""
echo "2️⃣  GitHub CLI (gh) version:"
if command -v gh >/dev/null 2>&1; then
  gh --version | head -n 1
  # Show protocol (ssh / https), if configured
  proto=$(gh config get git_protocol -h github.com 2>/dev/null)
  if [ -n "$proto" ]; then
    echo "   → Git protocol for github.com: $proto"
  fi
else
  echo "❌ gh (GitHub CLI) not found (brew install gh)."
fi

echo ""
echo "3️⃣  SSH key(s) in home (~/.ssh):"
if ls -l ~/.ssh/id_*.pub 2>/dev/null; then
  :
else
  echo "❌ No SSH public key found!"
fi
if [ -f ~/.ssh/id_ed25519.pub ]; then
  echo "🟢 id_ed25519.pub present"
else
  echo "🔴 id_ed25519.pub NOT found"
fi

echo ""
echo "4️⃣  Latest SSH key fingerprint (id_ed25519.pub):"
if [ -f ~/.ssh/id_ed25519.pub ]; then
  ssh-keygen -lf ~/.ssh/id_ed25519.pub
else
  echo "ℹ️ No id_ed25519.pub – skipping fingerprint check."
fi

echo ""
echo "5️⃣  SSH agent status and loaded keys:"

if [ -f ~/.ssh/id_ed25519 ]; then
  agent_output="$(ssh-add -l 2>&1)"
  agent_status=$?

  if [ $agent_status -eq 0 ]; then
    # Keys are already loaded in the agent
    echo "$agent_output"
  else
    if echo "$agent_output" | grep -q "The agent has no identities."; then
      echo "⚠️  SSH agent is running, but no keys are loaded."
      echo "    → Trying to automatically add ~/.ssh/id_ed25519 to the agent ..."

      # Load key into the agent (with macOS keychain integration)
      ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null

      # Check again
      agent_output2="$(ssh-add -l 2>&1)"
      if [ $? -eq 0 ]; then
        echo "🟢 Key successfully added to SSH agent:"
        echo "    $agent_output2"
      else
        echo "🔴 Failed to add key to SSH agent:"
        echo "    $agent_output2"
      fi
    else
      echo "ℹ️  No SSH agent running or not reachable:"
      echo "    $agent_output"
    fi
  fi
else
  echo "ℹ️  No private id_ed25519 key (~/.ssh/id_ed25519) – skipping agent check."
fi

echo ""
echo "6️⃣  TEST: GitHub SSH login (may take ~2 seconds)..."
if command -v ssh >/dev/null 2>&1; then
  ssh -T git@github.com 2>&1 | grep -E "Hi |denied|refused|not provide shell access" || echo "ℹ️ No clear SSH response received."
else
  echo "❌ ssh not found."
fi

echo ""
echo "7️⃣  TEST: GitHub CLI auth status:"
if command -v gh >/dev/null 2>&1; then
  gh auth status 2>&1
else
  echo "ℹ️ gh not installed – skipping auth status."
fi

echo ""
echo "8️⃣  Check: copy public key (id_ed25519.pub) to clipboard:"
if [ -f ~/.ssh/id_ed25519.pub ]; then
  if command -v pbcopy >/dev/null 2>&1; then
    pbcopy < ~/.ssh/id_ed25519.pub
    echo "🟢 Public key was copied to the clipboard (ready to paste into GitHub)."
  else
    echo "ℹ️ pbcopy not available – skipping clipboard step."
  fi
else
  echo "ℹ️ No id_ed25519.pub – nothing to copy."
fi

echo ""
echo "✅ System check finished! Review the output above."
