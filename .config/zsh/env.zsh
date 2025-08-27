# Environment variables and PATH setup

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="cursor --wait"

# Base PATH additions
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Less configuration
# -x2: Use 2 spaces for tabs
# -R: Allow ANSI color escape sequences
# -F: Exit if content fits on one screen
export LESS='-x2 -RF'

# Colors for ls
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# History configuration
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000
HIST_STAMPS="mm/dd/yyyy"

# History options
setopt EXTENDED_HISTORY       # Record timestamp of commands
setopt HIST_EXPIRE_DUPS_FIRST # Delete duplicates first when HISTFILE exceeds HISTSIZE
setopt HIST_IGNORE_ALL_DUPS   # Ignore duplicated commands history list
setopt HIST_IGNORE_SPACE      # Ignore commands starting with a space
setopt HIST_VERIFY            # Show command before executing from history expansion
setopt INC_APPEND_HISTORY     # Add commands to HISTFILE in order of execution
setopt SHARE_HISTORY          # Share command history across all sessions

# Completion configuration
COMPLETION_WAITING_DOTS="true"
