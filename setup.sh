#!/bin/bash
set -eu -o pipefail

repo="$(realpath $(dirname ${BASH_SOURCE[0]}))"
plugin_dir="$HOME/.config/zsh-plugins"
echo "Setting up dotfiles from ${repo}"

function setup_macos() {
	defaults write -g InitialKeyRepeat -int 15
	defaults write -g KeyRepeat -int 2

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

	rg --generate complete-zsh >"$completion_dir/_rg"
	mise completion zsh >"$completion_dir/_mise"
	gh completion -s zsh >"$completion_dir/_gh"

	# Git completion
	if [ ! -f ~/.git-completion.zsh ]; then
		echo "Downloading git completion..."
		curl -o ~/.git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
	fi
}

# Install zsh plugins
function setup_zsh_plugins() {
	echo "Setting up zsh plugins..."

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

main
