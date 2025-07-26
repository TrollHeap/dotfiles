#!/usr/bin/env bash

# Définir ROOT_ENV si pas déjà défini
: "${ROOT_ENV:="$(cd "$(dirname "$0")" && pwd)"}"

# Déclaration des chemins standards du projet
C_CORE="$ROOT_ENV/core"
C_TOOLS="$ROOT_ENV/core/modules/tools"
C_MODULES="$ROOT_ENV/core/modules"

source "$ROOT_ENV/main.sh"
source "$ROOT_ENV/core/lib/logger.sh"
source "$ROOT_ENV/core/lib/validate.sh"

log::section "Running selfcheck"

for bin in git curl wget unzip zsh stow; do
    validate::binary "$bin"
done

for dir in "$C_CORE" "$C_TOOLS" "$C_MODULES";do
    validate::directory "$dir"
done

log::success "All system requirements satisfied."
