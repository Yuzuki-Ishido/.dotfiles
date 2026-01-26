# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# removing 'compdef: command not found' error from zsh auto-completion
autoload -Uz compinit
compinit


# Export nvim completion settings for lukechilds/zsh-nvm plugin
# Note: This must be exported before the plugin is bundled
export NVIM_DIR=${HOME}/.nvm
export NVM_COMPLETION=true

# setting up japanese language support
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS="@im=fcitx"

# source antidote
source ~/.antidote/antidote.zsh

# Set the root name of plugins file (.txt and .zsh) antidote will use.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins

if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source ~/.antidote/antidote.zsh
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi 

source ${zsh_plugins}.zsh

# tmux auto titling removal
export DISABLE_AUTO_TITLE=true

# source shellfiles
source ~/shellfiles/.shell_exports
source ~/shellfiles/.shell_aliases

# set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# start Starship Prompt
eval "$(starship init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
