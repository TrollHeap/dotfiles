#!/usr/bin/env bash

source "$(dirname "$0")/env.sh"
source "$C_CORE/logger.sh"
source "$C_CORE/validate.sh"

log::section "Running selfcheck"

for bin in git curl wget unzip zsh stow; do
    validate::binary "$bin"
done

for dir in "$C_CORE" "$C_TOOLS" "$C_MODULES" "$C_LOGS"; do
    validate::directory "$dir"
done

log::success "All system requirements satisfied."
