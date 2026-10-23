export EDITOR=nvim
alias vim=nvim
export PATH="$HOME/.local/bin:$PATH"
source $HOME/.cargo/env
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(worktree-bin init bash)"
source "$HOME/.config/shell/functions.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
