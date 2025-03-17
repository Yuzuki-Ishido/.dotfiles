# shell file used to automate the building of an neovim based ide
# using nix as a package manager and zsh as a shell 

# install nix
curl -L https://nixos.org/nix/install | sh

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install nix plugins
nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.git \
	nixpkgs.antibody \
	nixpkgs.neovim \
	nixpkgs.tmux \
	nixpkgs.stow \
	nixpkgs.yarn \
	nixpkgs.fzf \
	nixpkgs.ripgrep \
	nixpkgs.bat \
	nixpkgs.direnv

# add zsh to usable/valid login shells
command -v zsh | sudo tee -a /etc/shells

# set zsh as default shell
sudo chsh -s $(which zsh) $USER

# antibody bundle zsh plugins
antibody bundle < ~/.zsh_plugins.txt> ~/.zsh_plugins.sh

# stow source
source stow_folders.sh

for folder in $(echo $(STOW_FOLDERS))
do
  stow -D folder
  stow folder
done

