# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

for config in ~/.config/zsh/{env,functions,aliases,tools,completions,interactive}.zsh; do
	[[ -r "$config" ]] && source "$config"
done

plugins=(autosuggestions syntax-highlighting)
for plugin in $plugins; do
	source_if ~/.config/zsh-plugins/zsh-$plugin/zsh-$plugin.zsh
done

source_if ~/.env
source_if ~/.work.zshrc
