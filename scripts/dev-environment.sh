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

### LSPs & Formatters
npm install -g typescript typescript-language-server
npm install -g @tailwindcss/language-server
npm install -g prettier

curl -fsSL https://deno.land/install.sh | sh

go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest

yay -S --noconfirm --needed lua-language-server

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
# Go air
go install github.com/air-verse/air@latest

chsh -s /usr/bin/zsh 
sudo chsh -s /usr/bin/zsh
