status is-interactive; or return

if type -q atuin
    atuin init fish --disable-up-arrow | source
end
