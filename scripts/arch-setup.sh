#!/bin/bash

set -e

cd ~

# 1. Install git if not already present 
sudo pacman -Syu --noconfirm

# 2. Install yay (AUR helper) if not already installed
if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --noconfirm
  cd -
  rm -rf /tmp/yay
fi

# Dotfiles setup
yay -S --noconfirm --needed unzip stow

if [ -d ~/dotfiles ]; then
 cd ~/dotfiles
 rm -rf ~/.bashrc
 stow terminal 
 cd ~
fi

# 3. Install packages by category

## System & Core Utilities
yay -S --noconfirm --needed\
  pacman-contrib \
  zram-generator \
  tree \
  upower \
  reflector \
  reflector-simple \
  wget \
  iputils \
  gvfs \
  gnu-netcat \


## zram setup
sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
EOF

# Show zram status
echo "ZRAM status:"
swapon --show

### Graphics Drivers
yay -S --noconfirm --needed \
  mesa \
  lib32-mesa \
  vulkan-intel \
  lib32-vulkan-intel 

## Audio, Bluetooth, and Power
yay -S --noconfirm --needed \
  pipewire \
  pipewire-alsa \
  pipewire-pulse \
  pipewire-jack \
  wireplumber \
  alsa-utils \
  pwvucontrol \
  pamixer \
  playerctl \
  blueman \
  auto-cpufreq \

sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now auto-cpufreq.service

## Ly (just in case)
yay -S --noconfirm --needed \
  ly

sudo systemctl enable ly.service

# 4. Optional: Clean up
yay -Sc --noconfirm

echo "All done! You may want to log out and back in, or reboot, to ensure all services are running."

