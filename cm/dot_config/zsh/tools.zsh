# External tool integrations

# powerlevel10k (prompt)
source "$HOME/.config/zsh-plugins/powerlevel10k/powerlevel10k.zsh-theme"
source ~/.p10k.zsh

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

# Postgres (brew-installed postgresql@17)
export PATH="$HOMEBREW_PREFIX/opt/postgresql@17/bin:$PATH"
export PGDATA="$HOMEBREW_PREFIX/var/postgresql@17"

# mise (tool manager)
eval "$(mise activate zsh)"

# fzf (fuzzy finder)
source <(fzf --zsh)

# zoxide (smart directory navigation)
eval "$(zoxide init zsh)"

# direnv (per-directory env vars; required for git worktree env rewrites)
eval "$(direnv hook zsh)"
