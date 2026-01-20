# Completion system configuration

# Load completion system
fpath=($HOME/.zsh-complete $fpath)
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

# Completion behavior (oh-my-zsh style)
zmodload -i zsh/complist
unsetopt menu_complete
setopt auto_menu
setopt complete_in_word
setopt always_to_end

# Completion menu selection and navigation
zstyle ':completion:*' menu select
zstyle ':completion:*' completions 1
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' ignore-case true
# Case insensitive + substring matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' case-insensitive true
zstyle ':completion:*' original true
bindkey -M menuselect '^o' accept-and-infer-next-history

# Shift-Tab for reverse completion navigation
if [[ -n "${terminfo[kcbt]}" ]]; then
	bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

# Completion waiting dots
if [[ ${COMPLETION_WAITING_DOTS:-false} != false ]]; then
	expand-or-complete-with-dots() {
		[[ $COMPLETION_WAITING_DOTS = true ]] && COMPLETION_WAITING_DOTS="…"
		printf '\\e[?7l%s\\e[?7h' "$COMPLETION_WAITING_DOTS"
		zle expand-or-complete
		zle redisplay
	}
	zle -N expand-or-complete-with-dots
	bindkey "^I" expand-or-complete-with-dots
fi

# AWS CLI completion (lazy loaded)
if command -v aws >/dev/null; then
	_aws_lazy() {
		complete -C aws_completer aws
		unfunction _aws_lazy
		_normal
	}
	compdef _aws_lazy aws
fi

# Git completion
zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
