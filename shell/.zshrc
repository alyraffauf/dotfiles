# ~/.zshrc

if [[ -z ${ZSH_PROFILE_SOURCED:-} && -r "$HOME/.profile" ]]; then
    source "$HOME/.profile"
fi

alias grep='grep --color=auto'

for integration in "$HOME"/.config/shell/*.zsh(N); do
    source "$integration"
done
unset integration
