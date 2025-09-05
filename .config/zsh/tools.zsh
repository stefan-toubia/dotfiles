# External tool integrations

# TODO: Brew is too slow, and it still seems to work without it. Remove?
# brew (package manager - macOS only)
if [[ "$(uname)" == "Darwin" ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# mise (development environment manager)
eval "$(mise activate zsh)"

# fzf (fuzzy finder)
source <(fzf --zsh)

# zoxide (smart directory navigation)
eval "$(zoxide init zsh)"

# starship (prompt)
eval "$(starship init zsh)"
