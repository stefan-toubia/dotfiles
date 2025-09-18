#!/bin/bash
set -eu -o pipefail

repo="$(realpath $(dirname ${BASH_SOURCE[0]}))"
echo "Setting up dotfiles from ${repo}"

# Utility function to create symlinks
function link() {
	local source="$1"
	local target="$2"

	if [ -h "${target}" ]; then
		if [ "$(readlink "${target}")" == "${source}" ]; then
			return
		else
			echo "${target} is a symlink to a different file"
			return
		fi
	elif [ ! -e "${target}" ]; then
		mkdir -p "$(dirname ${target})"
		echo "linking ${target}"
		ln -s "${source}" "${target}"
	else
		echo -e "\033[33mWARN\033[0m ${target} exists but is not a symlink"
	fi
}

function setup_starship() {
	echo "Setting up starship..."
	if ! command -v starship &>/dev/null; then
		curl -sS https://starship.rs/install.sh | sh
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

# Configure macOS-specific settings
function setup_macos_config() {
	if [[ "$(uname)" != "Darwin" ]]; then
		return
	fi

	echo "Configuring macOS settings..."

	# Enable key repeating in VSCode and Cursor for vim extensions
	defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
	defaults write -app Cursor ApplePressAndHoldEnabled -bool false
}

# Link all dotfiles and configurations
function link_dotfiles() {
	echo "Linking dotfiles..."

	# Link main dotfiles
	link "${repo}/.editorconfig" ~/.editorconfig
	link "${repo}/.gitconfig" ~/.gitconfig
	link "${repo}/.zprofile" ~/.zprofile
	link "${repo}/.zshrc" ~/.zshrc
	link "${repo}/biome.json" ~/biome.json

	# Link .config directory contents
	mkdir -p ~/.config
	for f in $(find ${repo}/.config -mindepth 1 -maxdepth 1); do
		dst="${f/"${repo}"/$HOME}"
		link "${f}" "${dst}"
	done

	# Link script directory contents
	mkdir -p ~/script
	for f in $(find ${repo}/script -type f); do
		dst="${f/"${repo}"/$HOME}"
		link "${f}" "${dst}"
	done
}

function main() {
	setup_starship
	setup_completions
	setup_zsh_plugins
	setup_macos_config
	link_dotfiles
	echo "Setup complete!"
}

main
