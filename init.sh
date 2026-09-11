#!/usr/bin/env bash

set -e

PLUGINS_DIR="$HOME/.tmux/plugins"
TPM_DIR="$PLUGINS_DIR/tpm"

echo "==> Checking tmux plugins..."

# Check plugins directory
if [[ ! -d "$PLUGINS_DIR" ]]; then
    echo "[-] $PLUGINS_DIR does not exist."
    echo "[+] Creating plugins directory..."

    mkdir -p "$PLUGINS_DIR"

    echo "[+] Created: $PLUGINS_DIR"
else
    echo "[+] Plugins directory exists: $PLUGINS_DIR"
fi

# Check whether plugins directory is empty
if [[ -z "$(find "$PLUGINS_DIR" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
    echo "[!] Plugins directory is empty."
else
    echo "[+] Plugins directory contains:"
    find "$PLUGINS_DIR" -mindepth 1 -maxdepth 1 -type d -printf '    - %f\n'
fi

# Check TPM directory
if [[ ! -d "$TPM_DIR" ]]; then
    echo "[-] TPM is not installed."
    echo "[+] Installing TPM..."

    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"

    echo "[+] TPM installed."
else
    echo "[+] TPM directory exists: $TPM_DIR"
fi

# Check TPM contents
if [[ -z "$(find "$TPM_DIR" -mindepth 1 -print -quit 2>/dev/null)" ]]; then
    echo "[!] TPM directory is empty."
    echo "[+] Removing empty TPM directory..."

    rm -rf "$TPM_DIR"

    echo "[+] Installing TPM..."

    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"

    echo "[+] TPM installed."
else
    echo "[+] TPM contains files."
fi

echo
echo "==> tmux initialization complete."
