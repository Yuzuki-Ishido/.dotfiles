# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# removing 'compdef: command not found' error from zsh auto-compleetion
autoload -Uz compinit
compinit

# Export nvm completion settings for lukechilds/zsh-nvm plugin
# Note: This must be exported before the plugin is bundled
export NVM_DIR=${HOME}/.nvm
export NVM_COMPLETION=true

# source zsh plugins
source ~/.zsh_plugins.sh

# use nix
if [ -e /home/yuzuki/.nix-profile/etc/profile.d/nix.sh ]; then . /home/yuzuki/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source shellfiles
source ~/shellfiles/.shell_exports
source ~/shellfiles/.shell_aliases

# set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# bat theme
export BAT_THEME=tokyonight_night
