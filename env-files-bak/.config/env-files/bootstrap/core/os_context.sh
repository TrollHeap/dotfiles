#!/usr/bin/env bash
set -euo pipefail

source "$C_FUNCTIONS/detect_os.sh"
export OS="$(detect_os)"
