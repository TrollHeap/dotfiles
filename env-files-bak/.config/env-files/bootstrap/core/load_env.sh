#!/bin/bash
set -euo pipefail

if [[ -n "$C_ENV_LOADED" ]]; then return; fi
export C_ENV_LOADED=1

# Detect OS
source "$C_BOOTSTRAP/core/os_context.sh"

# 1. Load general paths
source "$C_PATHS/software-paths.env"

# 2. Load per-OS path variables
case "$OS" in
  macos)  source "$C_PATHS/os/macos-paths.env" ;;
  arch)   source "$C_PATHS/os/arch-paths.env" ;;
  ubuntu) source "$C_PATHS/os/ubuntu-paths.env" ;;
esac

# 3. Optional buildflags
[[ -f "$C_ENV/buildflag/macos_buildflags.env" ]] && source "$C_ENV/buildflag/macos_buildflags.env"
