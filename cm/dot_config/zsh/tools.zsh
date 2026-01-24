# External tool integrations

# powerlevel10k (prompt)
source "$HOME/.config/zsh-plugins/powerlevel10k/powerlevel10k.zsh-theme"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# TODO: Brew is too slow, and it still seems to work without it. Remove?
# brew (package manager - macOS only)
if [[ "$(uname)" == "Darwin" ]]; then
	if [[ "$(uname -m)" == "arm64" ]]; then
		# Apple Silicon Mac
		eval "$(/opt/homebrew/bin/brew shellenv)"
	else
		# Intel Mac
		eval "$(/usr/local/bin/brew shellenv)"
	fi
fi

# mise (development environment manager)
eval "$(mise activate zsh)"

# fzf (fuzzy finder)
source <(fzf --zsh)

# zoxide (smart directory navigation)
eval "$(zoxide init zsh)"
