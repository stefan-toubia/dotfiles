export EDITOR="code --wait"

function source_if() {
  [[ -f "$1" ]] && source "$1"
}

# zsh and oh my zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="amuse"
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(aws fasd git gh ripgrep tmux)

source_if $ZSH/oh-my-zsh.sh

### Aliases

alias zshrc="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"

alias lr='ls -R'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tns='tmux new-session -A -s'

alias display-swap="~/script/display_swap.sh"

if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$(uname)" == "Linux" ]]; then
  # TODO
fi

source_if ~/.fzf.zsh
source_if ~/.work.zshrc

set -u
