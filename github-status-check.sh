#!/bin/bash

echo "---- GITHUB SYSTEM CHECK (macOS) ----"
echo "User:    $(whoami)"
echo "Home:    $HOME"
echo "Hostname: $(hostname)"
echo ""

echo "1️⃣  GIT Version:"
if command -v git >/dev/null 2>&1; then
  git --version
else
  echo "❌ git nicht gefunden (Xcode CLT oder Homebrew installieren)"
fi

echo ""
echo "2️⃣  GitHub CLI (gh) Version:"
if command -v gh >/dev/null 2>&1; then
  gh --version | head -n 1
  # Protokoll anzeigen (ssh / https), wenn gesetzt
  proto=$(gh config get git_protocol -h github.com 2>/dev/null)
  if [ -n "$proto" ]; then
    echo "   → Git-Protokoll für github.com: $proto"
  fi
else
  echo "❌ gh (GitHub CLI) nicht gefunden (brew install gh)"
fi

echo ""
echo "3️⃣  SSH Key(s) im Home (~/.ssh):"
if ls -l ~/.ssh/id_*.pub 2>/dev/null; then
  :
else
  echo "❌ Kein SSH Public Key gefunden!"
fi
if [ -f ~/.ssh/id_ed25519.pub ]; then
  echo "🟢 id_ed25519.pub vorhanden"
else
  echo "🔴 id_ed25519.pub NICHT gefunden"
fi

echo ""
echo "4️⃣  Letzter SSH-Key Fingerprint (id_ed25519.pub):"
if [ -f ~/.ssh/id_ed25519.pub ]; then
  ssh-keygen -lf ~/.ssh/id_ed25519.pub
else
  echo "ℹ️ Kein id_ed25519.pub – Fingerprint wird übersprungen."
fi

echo ""
echo "5️⃣  SSH-Agent Status und geladene Keys:"

if [ -f ~/.ssh/id_ed25519 ]; then
  agent_output="$(ssh-add -l 2>&1)"
  agent_status=$?

  if [ $agent_status -eq 0 ]; then
    # Keys sind bereits im Agent
    echo "$agent_output"
  else
    if echo "$agent_output" | grep -q "The agent has no identities."; then
      echo "⚠️  SSH-Agent läuft, aber es sind keine Keys geladen."
      echo "    → Versuche jetzt automatisch, ~/.ssh/id_ed25519 in den Agent zu laden ..."

      # Key in den Agent laden (mit macOS Keychain-Integration)
      ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null

      # Nochmal prüfen
      agent_output2="$(ssh-add -l 2>&1)"
      if [ $? -eq 0 ]; then
        echo "🟢 Key wurde in den SSH-Agent geladen:"
        echo "    $agent_output2"
      else
        echo "🔴 Konnte keinen Key in den Agent laden:"
        echo "    $agent_output2"
      fi
    else
      echo "ℹ️  Kein SSH-Agent aktiv oder nicht erreichbar:"
      echo "    $agent_output"
    fi
  fi
else
  echo "ℹ️  Kein privater id_ed25519-Key (~/.ssh/id_ed25519) – Agent-Check wird übersprungen."
fi

echo ""
echo "6️⃣  TEST: GitHub SSH Login (wird ca. 2 Sek. dauern)..."
if command -v ssh >/dev/null 2>&1; then
  ssh -T git@github.com 2>&1 | grep -E "Hi |denied|refused|not provide shell access" || echo "ℹ️ Keine eindeutige SSH-Antwort erhalten."
else
  echo "❌ ssh nicht gefunden"
fi

echo ""
echo "7️⃣  TEST: GitHub CLI Auth-Status:"
if command -v gh >/dev/null 2>&1; then
  gh auth status 2>&1
else
  echo "ℹ️ gh nicht installiert – Auth-Status wird übersprungen."
fi

echo ""
echo "8️⃣  PRÜFUNG: Public Key (id_ed25519.pub) in die Zwischenablage kopieren:"
if [ -f ~/.ssh/id_ed25519.pub ]; then
  if command -v pbcopy >/dev/null 2>&1; then
    pbcopy < ~/.ssh/id_ed25519.pub
    echo "🟢 Public Key wurde in die Zwischenablage kopiert (zum Hochladen bereit)."
  else
    echo "ℹ️ pbcopy nicht verfügbar – Zwischenablage wird übersprungen."
  fi
else
  echo "ℹ️ Kein id_ed25519.pub – nichts zum Kopieren."
fi

echo ""
echo "✅ Systemcheck abgeschlossen! Prüfe die Ausgabe oben."

