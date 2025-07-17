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
HIST_STAMPS="mm/dd/yyyy"

# Completion configuration
COMPLETION_WAITING_DOTS="true"
