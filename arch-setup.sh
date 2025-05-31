#!/bin/bash

set -e

# 1. Install base-devel and git if not already present (required for building paru)
sudo pacman -Syu --needed base-devel git

# 2. Install paru (AUR helper) if not already installed
if ! command -v paru &>/dev/null; then
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru
  makepkg -si --noconfirm
  cd -
  rm -rf /tmp/paru
fi

# Dotfiles setup
paru -S --noconfirm --needed unzip stow

if [ ! -d dotfiles ]; then
  git clone --depth=1 https://github.com/dallas1295/dotfiles
fi
cd dotfiles
rm -rf ~/.bashrc
stow yazi nvim wezterm fastfetch rofi sway tmux terminal btop starship

# 3. Install packages by category

## System & Core Utilities
paru -S --noconfirm --needed\
  pacman-contrib \
  grub \
  zram-generator \
  tree \
  upower \
  reflector-simple

## zram setup
sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
EOF

# Start zram for this session (will auto-start on reboot)
sudo systemctl start systemd-zram-setup@zram0.service

# Show zram status
echo "ZRAM status:"
swapon --show

## Shells & CLI Tools
paru -S --noconfirm --needed \
  zsh \
  zsh-autosuggestions \
  zsh-completions \
  zsh-syntax-highlighting \
  starship \
  btop \
  fastfetch \
  yazi \
  lazygit \
  lazydocker \
  github-cli \
  go \
  zig \
  neovim \
  tmux \
  fd \
  fzf \
  entr

## Fonts & Themes
paru -S --noconfirm --needed \
  xdg-desktop-portal \
  xdg-desktop-portal-wlr \
  otf-nebula-sans \
  ttf-font-awesome \
  ttf-jetbrains-mono-nerd \
  rose-pine-cursor \
  rose-pine-gtk-theme

## Sway & Wayland Environment
paru -S --noconfirm --needed \
  sway \
  swaync \
  nwg-look \
  autotiling \
  cliphist \
  pamixer \
  pwvucontrol \
  flameshot \
  wl-clipboard \
  wezterm

## Audio, Bluetooth, and Power
paru -S --noconfirm --needed \
  blueman \
  auto-cpufreq \
  bt-dualboot

sudo systemctl enable --now auto-cpufreq.service

## Browsers & Apps
paru -S --noconfirm --needed \
  firefox \
  spotify \
  zen-browser-bin \
  steam \

## Flatpak
paru -S --noconfirm flatpak 

## Rofi & Menu
paru -S --noconfirm --needed \
  rofi \
  rofi-power-menu

# 4. Optional: Clean up
paru -Sc --noconfirm

echo "All done! You may want to log out and back in, or reboot, to ensure all services are running."

