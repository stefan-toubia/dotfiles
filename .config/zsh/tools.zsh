# External tool integrations

# TODO: Brew is too slow, and it still seems to work without it. Remove?
# brew (package manager - macOS only)
# if [[ "$(uname)" == "Darwin" ]] && command -v brew >/dev/null 2>&1; then
#   eval "$(brew shellenv)"
# fi

# mise (development environment manager)
eval "$(mise activate zsh)"

# fzf (fuzzy finder)
source <(fzf --zsh)

# zoxide (smart directory navigation)
eval "$(zoxide init zsh)"

# starship (prompt)
eval "$(starship init zsh)"
