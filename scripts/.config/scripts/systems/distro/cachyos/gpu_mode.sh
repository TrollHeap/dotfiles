#!/bin/bash

set -e

system_status_summary() {
  echo -e "\033[0;34m🔋 GPU/Power Status\033[0m"
  
  # GPU state (perf or eco)
  if [[ -f /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf ]]; then
    echo -e "🎮 Mode: \033[0;32mPerformance (NVIDIA actif)\033[0m"
  else
    echo -e "🔋 Mode: \033[0;33mÉconomie (iGPU actif)\033[0m"
  fi

  # NVIDIA performance state (if available)
  if command -v nvidia-smi &>/dev/null; then
    state=$(nvidia-smi --query-gpu=pstate --format=csv,noheader,nounits 2>/dev/null)
    util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)
    echo -e "📶 P-State: $state | 🎯 Utilisation GPU: ${util}%"
  fi

  # Power source
  if command -v upower &>/dev/null; then
    battery=$(upower -i $(upower -e | grep BAT) | grep state | awk '{print $2}')
    if [[ "$battery" == "charging" ]]; then
      echo -e "🔌 Alimentation: \033[0;36mSecteur (chargement)\033[0m"
    else
      echo -e "🔋 Alimentation: \033[0;33mBatterie\033[0m"
    fi
  fi

  echo ""
}

if [[ "$1" == "perf" ]]; then
  echo "[🔋 → 🎮] Bascule vers mode performance (NVIDIA activé)"
  sudo cp ~/gpu_profiles/10-nvidia-drm-outputclass.conf /etc/X11/xorg.conf.d/
  system_status_summary
  echo "Redémarre proprement pour appliquer."
elif [[ "$1" == "eco" ]]; then
  echo "[🎮 → 🔋] Bascule vers mode économie (NVIDIA désactivé)"
  sudo rm -f /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
  system_status_summary
  echo "Redémarre proprement pour appliquer."
else
  echo "Usage: $0 perf | eco"
fi

