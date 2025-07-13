# Interactive shell features

# Vim mode (native zsh)
set -o vi

# Editor integration - press 'v' in normal mode to edit in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# Preserve fzf history search in both insert and normal mode
bindkey '^R' fzf-history-widget

# Manual fzf cd widget (since Alt+C might be blocked by macOS)
bindkey '^F' fzf-cd-widget # Ctrl+F for directory navigation

# Auto suggestion key bindings
bindkey '^ ' autosuggest-accept
