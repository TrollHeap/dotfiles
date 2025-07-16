#!/usr/bin/env bash

detect_os() {
    [[ "$OSTYPE" == "darwin"* ]] && echo "macos" && return
    [[ -f /etc/os-release ]] && {
        . /etc/os-release
        case "$ID" in
            arch | manjaro | cachyos | endeavouros) echo "arch" ;;
            ubuntu | debian) echo "ubuntu" ;;
            fedora-asahi-remix | fedora | nobara) echo "fedora" ;;
            *) echo "$ID" ;;
        esac
        return
    }
    echo "unknown"
}
export OS="$(detect_os)"
log::info "Detected OS: $OS"
