if command -v eza &>/dev/null; then
    alias eza='eza --icons auto --git --group-directories-first --header'
    alias l='eza -lah'
    alias la='eza -a'
    alias ll='eza -l'
    alias lla='eza -la'
    alias ls=eza
    alias lt='eza --tree'
    alias tree='eza --tree'
fi
