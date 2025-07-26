#!/usr/bin/env bash

case "$OS" in
    ubuntu|debian|linxmint) log::try_source "$ROOT_ENV/config/paths/ubuntu-paths.env" ;;
    fedora) log::try_source "$ROOT_ENV/config/paths/fedora-paths.env" ;;
    *)      log::warn "No OS-specific path override for $OS" ;;
esac
