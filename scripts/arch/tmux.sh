#!/usr/bin/env bash
set -e

# tmux autoinstall script for Arch
CONF_URL="https://raw.githubusercontent.com/Knot-Here/init-bruv/refs/heads/main/config/.tmux.conf"
CONF_PATH="$HOME/.tmux.conf"
TPM_DIR="$HOME/.tmux/plugins/tpm"

echo "[+] Installing tmux..."
sudo pacman -Sy --needed --noconfirm tmux git curl

echo "[+] Fetching config..."
curl -fsSL "$CONF_URL" -o "$CONF_PATH"

echo "[+] Installing TPM..."
git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR" 2>/dev/null || true

echo "[+] Installing tmux plugins..."
tmux start-server
tmux new-session -d -s _tmp "sleep 1" || true
"$TPM_DIR/scripts/install_plugins.sh" || true
tmux kill-session -t _tmp 2>/dev/null || true

echo "[✓] tmux config installed and plugins bootstrapped."

