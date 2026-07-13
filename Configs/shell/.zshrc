export EDITOR=nvim
alias vim=nvim
export PATH="$HOME/.local/bin:$PATH"
source $HOME/.cargo/env
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(worktree-bin init zsh)"
source "$HOME/.config/shell/functions.sh"
