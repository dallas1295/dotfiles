#!/bin/bash

set -e

cd ~

if [ -d ~/dotfiles ]; then
 cd ~/dotfiles
 rm -rf ~/.bashrc
 stow nvim tmux yazi ghostty starship btop fastfetch
 cd ~
fi

### Dev necessities
echo 'Installing code packages...'
sleep 2
yay -S --noconfirm --needed \
  npm \
  go \
  zig \
  rust \
  cargo \
  luarocks \
  neovim \
  tmux \
  fd \
  fzf \
  entr \
  zoxide \

### Terminal stuff (Shell / CLI)
echo 'Installing terminal stuff...'
sleep 2 
yay -S --noconfirm --needed \
  tmux \
  lazygit \
  lazydocker \
  github-cli \
  docker \
  docker-compose \
  zsh \
  zsh-autosuggestions \
  zsh-completions \
  zsh-syntax-highlighting \
  starship \
  btop \
  fastfetch \
  yazi \



sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# TPM Install
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Deno
curl -fsSL https://deno.land/install.sh | sh

# Go air
go install github.com/air-verse/air@latest

chsh -s /usr/bin/zsh 
sudo chsh -s /usr/bin/zsh
