#!/usr/bin/env bash
set -euo pipefail

detect_os() {
    # macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
        return
    fi

    # Linux
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            arch | manjaro | cachyos | endeavouros) echo "arch" ;;
            ubuntu | debian)          echo "ubuntu" ;;
            fedora)                   echo "fedora" ;;
            *)                        echo "$ID" ;;
        esac
        return
    fi

    # Fallback
    echo "unknown"
}
