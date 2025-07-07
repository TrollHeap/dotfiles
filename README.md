# Dotfiles

This repository contains my personal configuration files used across different machines. It is organized with **GNU Stow**, so each directory represents a self‑contained module that can be symlinked into `~`.

---

## Features

* Centralized environment bootstrap scripts in `env-files` to set up packages and shell configuration on new systems.
* Ready‑to‑use configs for Zsh, tmux, WezTerm, Starship and more.
* Minimal Neovim and Yazi configuration as starting points.

## Supported OS

Currently supported:

* **Ubuntu**
* **Arch Linux** (and derivatives like EndeavourOS)
* **Fedora** (including Nobara)
* **macOS**

Planned support:

* **Debian**
* **Windows via WSL**

## Getting Started

1. **Clone the repository**

   ```bash
   git clone https://github.com/binary-grunt/dotfiles ~/dotfiles
   cd ~/dotfiles
   ```

2. **Bootstrap the environment** (optional)

   ```bash
   stow env-files
   make bootstrap
   ```

   This runs the scripts in `env-files` to install packages and set up tools depending on your OS.

3. **Deploy the dotfiles**

   ```bash
   make dotfiles
   ```

   or manually run `env-files/.config/env-files/modules/dotfiles/setup.sh`. This uses `stow` to create symlinks in your home directory.

## Directory Overview

* **env-files/** – Shell scripts and environment definitions. The `bootstrap` folder contains OS‑specific installation scripts and helpers. The `modules` directory handles dotfile deployment, workspace creation and tool installation.
* **bash/** – `.bashrc` and `.zshenv` for the Bash shell.
* **tmux/** – Configuration for the tmux terminal multiplexer and tmuxifier layouts.
* **starship/** – `starship.toml` prompt configuration.
* **wezterm/** – `wezterm.lua` configuration for the WezTerm terminal emulator.
* **nvim/** – Minimal Neovim setup stored under `.config/nvim`.
* **yazi/** – Basic configuration for the Yazi terminal file manager.
* **scripts/** – Utility shell and Python scripts used during bootstrap or for day‑to‑day tasks.
* **kde-zen/** – KDE related tweaks and exported settings.

## Requirements

* `git`
* `stow`

Some modules may require additional software like `tmux` or `wezterm`. The bootstrap process attempts to install them automatically when possible.

## Updating

After pulling new changes, you can reapply the symlinks by rerunning the deploy step:

```bash
make dotfiles
```

Enjoy your personalized environment!
