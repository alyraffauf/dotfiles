#!/usr/bin/env sh
set -eu

tpm_path="$HOME/.tmux/plugins/tpm"

if [ -x "$tpm_path/tpm" ]; then
    exit 0
fi

mkdir -p "$(dirname "$tpm_path")"

if git clone --depth=1 https://github.com/tmux-plugins/tpm "$tpm_path"; then
    exit 0
fi

test -x "$tpm_path/tpm"
