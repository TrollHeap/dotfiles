#!/usr/bin/env bash

declare -A DNF_HOOKS=(
  [lazygit]='if ! sudo dnf repolist | grep -q atim/lazygit; then
                echo "[+] Enabling Copr repo: atim/lazygit"
                sudo dnf copr enable atim/lazygit -y || exit 1
             fi'
  # Add new hooks here
)
