#!/bin/bash
set -eu -o pipefail

force=false

repo="$(realpath $(dirname ${BASH_SOURCE[0]}))"
echo "Setting up dotfiles from ${repo}"

function setup_macos() {
	defaults write -g InitialKeyRepeat -int 10
	defaults write -g KeyRepeat -int 1

	echo "Configuring macOS settings..."

	# Enable key repeating in VSCode and Cursor for vim extensions
	defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
	defaults write -app Cursor ApplePressAndHoldEnabled -bool false

	if ! command -v brew &>/dev/null; then
		echo "Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	fi
}

function setup_p10k() {
	echo "Setting up powerlevel10k..."
	local plugin_dir="$HOME/.config/zsh-plugins"
	mkdir -p "$plugin_dir"
	if [ ! -d "$plugin_dir/powerlevel10k" ]; then
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$plugin_dir/powerlevel10k"
	fi
}

# Set up shell completions
function setup_completions() {
	echo "Setting up shell completions..."

	local completion_dir="$HOME/.zsh-complete"
	mkdir -p "$completion_dir"

	# Ripgrep completion
	rg --generate complete-zsh >"$completion_dir/_rg"

	# Git completion
	if [ ! -f ~/.git-completion.zsh ]; then
		echo "Downloading git completion..."
		curl -o ~/.git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
	fi

	# GH completion
	gh completion -s zsh >"$completion_dir/_gh"
}

# Install zsh plugins
function setup_zsh_plugins() {
	echo "Setting up zsh plugins..."

	local plugin_dir="$HOME/.config/zsh-plugins"
	mkdir -p "$plugin_dir"

	# Install zsh-autosuggestions
	if [ ! -d "$plugin_dir/zsh-autosuggestions" ]; then
		git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir/zsh-autosuggestions"
	fi

	# Install zsh-syntax-highlighting
	if [ ! -d "$plugin_dir/zsh-syntax-highlighting" ]; then
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugin_dir/zsh-syntax-highlighting"
	fi
}

function main() {
	setup_macos
	brew bundle
	chezmoi init --source "$repo" --apply
	mise install
	setup_p10k
	setup_completions
	setup_zsh_plugins
	(cd $repo && lefthook install)
	echo "Setup complete!"
}

while [[ $# -gt 0 ]]; do
	case $1 in
	--force)
		force=true
		shift
		;;
	*)
		echo "Unknown option: $1"
		exit 1
		;;
	esac
done

main
