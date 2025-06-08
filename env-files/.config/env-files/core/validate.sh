#!/usr/bin/env bash

validate::binary() {
    local bin="$1"
    if ! command -v "$bin" &>/dev/null; then
        echo "❌ Required binary missing: $bin" >&2
        exit 1
    fi
}

validate::directory() {
    local path="$1"
    [[ -d "$path" ]] || {
        echo "❌ Directory does not exist: $path" >&2
        exit 1
    }
}

validate::file() {
    local path="$1"
    [[ -f "$path" ]] || {
        echo "❌ File does not exist: $path" >&2
        exit 1
    }
}

validate::arg_count() {
    local expected="$1"
    local actual="$#"
    [[ "$actual" -eq "$expected" ]] || {
        echo "❌ Invalid argument count: expected $expected, got $actual" >&2
        exit 1
    }
}
