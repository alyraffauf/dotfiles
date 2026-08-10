status is-interactive; or return

if type -q nix-your-shell
    nix-your-shell fish | source
end
