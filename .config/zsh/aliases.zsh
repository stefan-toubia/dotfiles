# Aliases organized by category

# Editor shortcuts
alias code="cursor"
alias zshrc="code $(readlink ~/.zshrc)"

# File operations
alias la='ls -la'
alias ll='ls -l'
alias lr='ls -R'

# Utility aliases
alias aliasf="alias | fzf"
alias copyprint="tee >(pbcopy)"
alias copyprintr="tee >(tr -d '\\n' | pbcopy)"

# Tmux shortcuts
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tns='tmux new-session -A -s'

# Development tools
alias display-swap="~/script/display_swap.sh"
alias tigs="tig status"

# fzf variations
alias fzfns="fzf --no-sort"
alias fzfp="fzf --preview 'bat --color=always {}'"
alias fzfpe='code $(fzfp)'
alias fzfc='fzf | copyprintr'

# Platform-specific aliases
if [[ "$(uname)" == "Darwin" ]]; then
	alias preview='open -a Preview'
fi
