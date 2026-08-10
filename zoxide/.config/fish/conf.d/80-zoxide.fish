status is-interactive; or return

if type -q zoxide
    zoxide init fish --cmd cd | source
end
