#!/usr/bin/env bash

case "$OS" in
    macos)  log::try_source "$C_PATHS/macos-paths.env" ;;
    arch)   log::try_source "$C_PATHS/arch-paths.env" ;;
    ubuntu) log::try_source "$C_PATHS/ubuntu-paths.env" ;;
    fedora) log::try_source "$C_PATHS/fedora-paths.env" ;;
    *)      log::warn "No OS-specific path override for $OS" ;;
esac
