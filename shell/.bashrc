# .bashrc
# shellcheck shell=bash

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
case ":$PATH:" in
    *":$HOME/.local/bin:$HOME/bin:"*) ;;
    *) PATH="$HOME/.local/bin:$HOME/bin:$PATH" ;;
esac
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Set up nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Set up Homebrew environment if available
homebrew_prefix=""

if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    homebrew_prefix="/home/linuxbrew/.linuxbrew"
elif [ -x /opt/homebrew/bin/brew ]; then
    homebrew_prefix="/opt/homebrew"
elif [ -x /usr/local/bin/brew ]; then
    homebrew_prefix="/usr/local"
fi

if [ -n "$homebrew_prefix" ]; then
    eval "$($homebrew_prefix/bin/brew shellenv)"

    if [ -d "$homebrew_prefix/opt/uutils-coreutils/libexec/uubin" ]; then
        export PATH="$homebrew_prefix/opt/uutils-coreutils/libexec/uubin:$PATH"
    fi

    if [ -d "$homebrew_prefix/opt/uutils-findutils/libexec/uubin" ]; then
        export PATH="$homebrew_prefix/opt/uutils-findutils/libexec/uubin:$PATH"
    fi
fi
unset homebrew_prefix

# Keep user-installed development tools ahead of system tools.
path_prepend() {
    local path_dir="$1"
    local path_entry
    local -a path_entries=()

    if [ ! -d "$path_dir" ]; then
        return
    fi

    IFS=: read -r -a path_entries <<< "$PATH"
    PATH="$path_dir"

    for path_entry in "${path_entries[@]}"; do
        [ "$path_entry" = "$path_dir" ] && continue
        PATH="$PATH:$path_entry"
    done
}

path_prepend "$HOME/.nix-profile/bin"
path_prepend "$HOME/go/bin"
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"
path_prepend "$HOME/.bun/bin"
path_prepend "$HOME/.cargo/bin"
path_prepend "$HOME/.local/share/pnpm"
path_prepend "$HOME/.deno/bin"
path_prepend "$HOME/.volta/bin"
path_prepend "$HOME/.npm-global/bin"

unset -f path_prepend

alias grep='grep --color=auto'

for integration in "$HOME"/.config/shell/*.bash; do
    [ -r "$integration" ] || continue
    . "$integration"
done
unset integration
