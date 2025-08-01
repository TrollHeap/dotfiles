#!/usr/bin/env bash

source "$ROOT_ENV/core/lib/installer.sh"

nerdfonts::installed() {
    local fonts_dir="$HOME/.local/share/fonts"
    find "$fonts_dir" -type f -iname '*JetBrainsMono*' -iname '*.ttf' | grep -q .
}

nerdfonts::install() {
    local fonts_dir="$HOME/.local/share/fonts"

    if nerdfonts::installed; then
        echo "[✓] Nerd Fonts already installed, skipping."
        return 0
    fi

    local github_url="https://github.com/ryanoasis/nerd-fonts/releases/download"
    local version_jetbrains="v3.0.2"
    local version_others="v3.3.0"

    mkdir -p "$fonts_dir"
    cd "$fonts_dir" || {
        echo "❌ Failed to access $fonts_dir"
        return 1
    }

    echo "[+] Installing Nerd Fonts…"

    declare -A fonts=(
        ["JetBrainsMono"]=$version_jetbrains
        ["NerdFontsSymbolsOnly"]=$version_others
        ["GeistMono"]=$version_others
    )

    for font in "${!fonts[@]}"; do
        local version="${fonts[$font]}"
        local archive="$font.zip"
        local url="$github_url/$version/$archive"

        if [[ ! -f "$archive" ]]; then
            echo "Downloading $font from $url"
            wget -q "$url" -O "$archive" || {
                echo "❌ Failed to download $font"
                continue
            }
        fi

        unzip -o "$archive" && rm -f "$archive"
    done

    fc-cache -fv
}
