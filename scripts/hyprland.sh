#!/bin/bash

set -e

# Ensure yay is installed
if ! command -v yay &>/dev/null; then
  echo "yay is required. Please install yay first."
  exit 1
fi

 if [ -d ~/dotfiles ]; then
 cd ~/dotfiles
 rm -rf ~/.bashrc
 stow ghostty hypr waybar rofi
 cd ~
fi


echo 'Installing Hyprland and stuff...'
sleep 2
# Hyprland and ecosystem
yay -S --needed --noconfirm \
  hyprland \
  hyprlock \
  hypridle \
  rose-pine-hyprcursor \
  swaync \
  waybar \
  xorg-wayland \
  xdg-desktop-portal \
  xdg-desktop-portal-hyprland \
  wl-clipboard \
  brightnessctl \
  nwg-look \
  thunar \
  thunar-volman \
  cliphist \
  ghostty \
  rofi-wayland \
  rofi-power-menu

echo 'Installing other apps now....'
sleep 2

## Fonts 
yay -S --noconfirm --need \
  otf-nebula-sans \
  ttf-font-awesome \
  ttf-font-awesome \
  ttf-fira-code \
  ttf-fira-code-nerd



# Browsers & Apps
yay -S --noconfirm --needed \
  firefox \
  spotify \
  zen-browser-bin \
  steam \
  surfshark-client \
  gimp \
  flatpak 

flatpak install -y flathub com.bitwarden.desktop

# Wezterm terminfo
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wezterm/wezterm/main/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile

# Set zen to default browser
xdg-settings set default-web-browser zen-browser.desktop
xdg-mime default zen-browser.desktop x-scheme-handler/http
xdg-mime default zen-browser.desktop x-scheme-handler/https

# Set GIMP for default w/ images
xdg-mime default gimp.desktop image/jpeg
xdg-mime default gimp.desktop image/jpg
xdg-mime default gimp.desktop image/gif
xdg-mime default gimp.desktop image/bmp
xdg-mime default gimp.desktop image/webp
xdg-mime default gimp.desktop image/png



echo "Hyprland environment setup complete!"
