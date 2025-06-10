#!/usr/bin/env bash

BUILD_FLAG_FILE="$C_CONFIG/buildflag/${OS}_buildflags.env"
[[ -f "$BUILD_FLAG_FILE" ]] && source "$BUILD_FLAG_FILE" && log::info "Loaded build flags" || log::info "No build flags for $OS"
