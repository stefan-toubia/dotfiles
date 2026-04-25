# Aliases organized by category

# Shortcuts
alias code="cursor"
zshrc() { code "$(readlink -f ~/.zshrc)"; }
alias lg="lazygit"
alias cm="chezmoi"

# File operations
alias ls=eza
alias la='ls -la'
alias ll='ls -l'
alias lr='ls -R'
alias lt='ls -T'
alias lti='lt --git-ignore'
alias l1='eza -1'
alias lsize='eza -l --no-permissions --no-user --no-time'

# Utility aliases
alias aliasf="alias | fzf"
alias cat='bat --paging=never --plain'
alias copyprint="tee >(pbcopy)"
alias copyprintr="tee >(tr -d '\\n' | pbcopy)"
alias rgc="rg --color=always --heading --line-number"
alias tre='tree -a -I ".git" --gitignore --prune'
alias fd1='fd -d1'
alias fda='fd -IH'
alias fda1='fd -IH -d1'
alias fmtiec='numfmt --to=iec'

# Bat aliases
alias batcue="bat --language cue"
alias batj="bat --language json"
alias batman="bat --language man"
alias batsql="bat --language sql"
alias sbat='bat --paging=never -l log --style plain'
alias sbatj='bat --paging=never -l json --style plain'

# Tmux shortcuts
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tns='tmux new-session -A -s'

# Development tools
alias display-swap="~/scripts/display_swap.sh"

# fzf variations
alias fzfns="fzf --no-sort"
alias fzfp="fzf --preview 'bat --color=always {}'"
alias fzfpe='code $(fzfp)'
alias fzfc='fzf | copyprintr'

# Platform-specific aliases
if [[ "$(uname)" == "Darwin" ]]; then
	alias preview='open -a Preview'
fi

# Language-specific aliases
alias gota="go test ./..."
alias gota1="go test -count 1 ./..."
