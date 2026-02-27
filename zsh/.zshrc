eval "$(starship init zsh)"


# Antidote - ZSH Plugin Manager
# source '/usr/share/zsh-antidote/antidote.zsh'
source "$HOME/.antidote/antidote.zsh"

Z_PLUGINS="$HOME/.zsh_plugins/.zsh_plugins"

if [[ -f "${Z_PLUGINS}.txt" ]]; then
  # Generate a new .zsh_plugins.zsh file if:
  # 1. said file does not exist.
  # 2. .txt file is newer than the compiled .zsh file
  if [[ ! -f "${Z_PLUGINS}.zsh" || "${Z_PLUGINS}.txt" -nt "${Z_PLUGINS}.zsh" ]]; then
    echo "Updating compiled Antidote plugins."
    antidote bundle < "${Z_PLUGINS}.txt" > "${Z_PLUGINS}.zsh"
  fi

  # Source compiled plugin file
  source "${Z_PLUGINS}.zsh"
fi

# Other plugins
source <(fzf --zsh)
source /usr/share/zsh/plugins/zsh-you-should-use/zsh-you-should-use.plugin.zsh



# sourcing shellfiles
SHELLFILES="$HOME/shellfiles"

setopt local_options null_glob

for file in "$SHELLFILES"/.*(.N); do
  source "$file"
done


fastfetch
