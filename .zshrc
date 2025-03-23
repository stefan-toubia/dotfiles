export EDITOR="code --wait"

function source_if() {
  [[ -f "$1" ]] && source "$1"
}

# -x2: Use 2 spaces for tabs
# -R: Allow ANSI color escape sequences
# -F: Exit if content fits on one screen
export LESS='-x2 -RF'

# zsh and oh my zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="amuse"
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm/dd/yyyy"
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(aws fasd git gh ripgrep tmux zsh-vi-mode virtualenv)

source_if $ZSH/oh-my-zsh.sh

### Aliases

alias zshrc="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"

alias lr='ls -R'
alias aliasf="alias | fzf"

# ohmyzsh tmux plugin provided aliases:
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tns='tmux new-session -A -s'

alias display-swap="~/script/display_swap.sh"
alias tigs="tig status"

if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  # Enable key repeating in VSCode for VSCodeVim
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  alias preview='open -a Preview'
elif [[ "$(uname)" == "Linux" ]]; then
  # TODO
fi

source <(fzf --zsh)
alias fzfns="fzf --no-sort"
alias fzfp="fzf --preview 'bat --color=always {}'"
alias fzfpe='code $(fzfp)'

source_if ~/.work.zshrc

function zvm_after_init() {
  zvm_bindkey viins "^R" fzf-history-widget
}
