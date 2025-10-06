#!/usr/bin/env bash
set -euo pipefail

CONF_URL="https://raw.githubusercontent.com/Knot-Here/init-bruv/refs/heads/main/config/.tmux.conf"
CONF_PATH="$HOME/.tmux.conf"
TPM_DIR="$HOME/.tmux/plugins/tpm"

echo "[+] Installing packages (tmux, git, curl, and helpers)…"
sudo pacman -Sy --needed --noconfirm tmux git curl \
  xclip wl-clipboard acpi lm_sensors \
  ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono || true
# ^ fonts are optional but help statusbar icons render

echo "[+] Fetching tmux config…"
curl -fsSL "$CONF_URL" -o "$CONF_PATH"

echo "[+] Ensuring TPM is installed…"
if [ -d "$TPM_DIR/.git" ]; then
  git -C "$TPM_DIR" pull --ff-only
else
  mkdir -p "$(dirname "$TPM_DIR")"
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi
chmod +x "$TPM_DIR"/tpm "$TPM_DIR"/bin/*

echo "[+] Bootstrapping plugins with TPM…"
# If tmux is already running, use that server; otherwise spin a temp session.
if tmux has-session 2>/dev/null; then
  tmux source-file "$CONF_PATH" || true
  "$TPM_DIR/bin/install_plugins" || true
  "$TPM_DIR/bin/update_plugins" all || true
else
  tmux start-server
  tmux -f "$CONF_PATH" new-session -d -s __tpm_bootstrap "sleep 1"
  "$TPM_DIR/bin/install_plugins" || true
  "$TPM_DIR/bin/update_plugins" all || true
  tmux kill-session -t __tpm_bootstrap 2>/dev/null || true
fi

echo "[+] Reloading tmux to apply theme…"
# Reload all attached sessions to pick up the theme immediately
tmux source-file "$CONF_PATH" 2>/dev/null || true

echo "[✓] Done. If you’re inside tmux, press Prefix + r to reload, or just restart tmux."

