status is-interactive; or return

if type -q fzf
    fzf --fish | source
end
