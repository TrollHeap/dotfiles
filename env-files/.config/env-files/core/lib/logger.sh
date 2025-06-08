#!/usr/bin/env bash

# ─── logger.sh : fichier-only, pas de stdout ───────────────────────────────

# log::use <KEY> — active un fichier cible LOG_<KEY>
log::use() {
  local key="$1"
  local var="LOG_${key}"

  if ! eval "[[ -n \"\${$var:-}\" ]]"; then
    echo "log::use: unknown or unset key '$key' (expected var $var)" >&2
    return 1
  fi

  eval "LOG_FILE=\"\${$var}\""
  mkdir -p "$(dirname "$LOG_FILE")"
}

# log::try_source <file> [label]
log::try_source() {
  local file="$1" label="${2:-$file}"
  if [[ -f "$file" ]]; then
    source "$file"
    log::info "Loaded $label"
  else
    log::warn "File not found: $label ($file)"
  fi
}

# Format : écrit dans $LOG_FILE uniquement
_log::write() {
  local level="$1" emoji="$2" message="$3"
  local ts; ts="$(date '+%Y-%m-%d %H:%M:%S')"
  echo "[$ts] [$level] $message" >> "$LOG_FILE"

  [[ "$level" == "ERROR" ]] && echo "❌ $message" >&2
}

# API
log::info()    { _log::write "INFO"  "🟦" "$*"; }
log::success() { _log::write "OK"    "🟩" "$*"; }
log::warn()    { _log::write "WARN"  "🟨" "$*"; }
log::error()   { _log::write "ERROR" "🟥" "$*"; }
log::debug()   { [[ "${DEBUG:-0}" == 1 ]] && _log::write "DEBUG" "⬛" "$*"; }

# section = démarcation logique (pas d'affichage)
log::section() {
  echo -e "\n# --- $* ---\n" >> "$LOG_FILE"
}

# mute/unmute = no-op ici (utile si tu ajoutes mode mixte plus tard)
log::mute()    { :; }
log::unmute()  { :; }
