export EDITOR=nvim
alias vim=nvim
export PATH="$HOME/.local/bin:$PATH"
source $HOME/.cargo/env
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(worktree-bin init bash)"
source "$HOME/.config/shell/functions.sh"
