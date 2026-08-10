status is-interactive; or return

if type -q starship
    starship init fish | source
end
