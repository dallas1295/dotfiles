#!/bin/bash

set -e

cd ~

# 1. Install git if not already present 
sudo pacman -Syu --needed git base-devel

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
 stow terminal tmux sway btop nvim rofi wezterm fastfetch starship tmux yazi
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
  gnu-netcat


## zram setup
sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
EOF

# Show zram status
echo "ZRAM status:"
swapon --show

## Shells & CLI Tools
yay -S --noconfirm --needed \
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

  # TPM Install
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  # Deno
  curl -fsSL https://deno.land/install.sh | sh

  # Go air
  go install github.com/air-verse/air@latest

  chsh -s /usr/bin/zsh 
  sudo chsh -s /usr/bin/zsh

### Graphics Drivers
yay -S --noconfirm --needed \
  mesa \
  lib32-mesa \
  vulkan-intel \
  lib32-vulkan-intel 

## Fonts & Themes
yay -S --noconfirm --needed \
  xorg-xwayland \
  xdg-desktop-portal \
  xdg-desktop-portal-wlr \
  otf-nebula-sans \
  ttf-font-awesome \
  ttf-jetbrains-mono-nerd \
  noto-fonts \
  noto-fonts-extra \
  noto-fonts-cjk \
  noto-fonts-emoji \
  ttf-fira-code \
  ttf-fira-code-nerd


# --- Rose Pine GTK3 Theming ---
mkdir -p ~/.themes ~/.tmp/gtk3_extract
cd ~/.tmp/gtk3_extract

GTK3_TARBALL="gtk3.tar.gz"
curl -fLO --progress-bar --retry 5 https://github.com/rose-pine/gtk/releases/latest/download/$GTK3_TARBALL

tar -xzf "$GTK3_TARBALL" -C .
rm "$GTK3_TARBALL"

find . -maxdepth 2 -type d \( -name "rose-pine-gtk" -o -name "rose-pine-*-gtk" \) -exec mv {} ~/.themes/ \; 2>/dev/null || true

cd ~
rm -rf ~/.tmp/gtk3_extract

# --- Rose Pine GTK4 Theming ---
mkdir -p ~/.config/gtk-4.0 ~/.tmp/gtk4_extract
cd ~/.tmp/gtk4_extract

GTK4_TARBALL="gtk4.tar.gz"
curl -fLO --progress-bar --retry 5 https://github.com/rose-pine/gtk/releases/latest/download/$GTK4_TARBALL

tar -xzf "$GTK4_TARBALL" -C .
rm "$GTK4_TARBALL"

GTK4_SOURCE_DIR=$(find . -maxdepth 2 -type d -name "gtk-4.0" | head -n 1)

if [ -n "$GTK4_SOURCE_DIR" ]; then
    cp -r "$GTK4_SOURCE_DIR"/assets ~/.config/gtk-4.0/ 2>/dev/null || true
    cp -f "$GTK4_SOURCE_DIR"/gtk.css ~/.config/gtk-4.0/ 2>/dev/null || true
    cp -f "$GTK4_SOURCE_DIR"/gtk-dark.css ~/.config/gtk-4.0/ 2>/dev/null || true
fi

cd ~
rm -rf ~/.tmp/gtk4_extract

# --- Rose Pine Icons ---
mkdir -p ~/.icons
cd ~/.icons
if [ ! -d "rose-pine-icons" ]; then
    ICONS_TARBALL="rose-pine-icons.tar.gz"
    curl -fLO --progress-bar --retry 5 https://github.com/rose-pine/gtk/releases/latest/download/$ICONS_TARBALL
    
    mkdir -p ~/.tmp/icons_extract
    tar -xzf "$ICONS_TARBALL" -C ~/.tmp/icons_extract
    rm "$ICONS_TARBALL"

    find ~/.tmp/icons_extract -maxdepth 2 -type d -name "rose-pine-icons" -exec mv {} . \; 2>/dev/null || true
    rm -rf ~/.tmp/icons_extract
fi
cd ~

# --- Rose Pine Cursor ---

CURSOR_THEME_NAME="BreezeX-RosePine-Linux"
CURSOR_DOWNLOAD_URL="https://github.com/rose-pine/cursor/releases/download/v1.1.0/BreezeX-RosePine-Linux.tar.xz"
CURSOR_FILENAME="BreezeX-RosePine-Linux.tar.xz"
CURSOR_INSTALL_DIR="$HOME/.local/share/icons"

mkdir -p "$CURSOR_INSTALL_DIR"
cd "$CURSOR_INSTALL_DIR"
if [ ! -d "$CURSOR_THEME_NAME" ]; then
    curl -fLO --progress-bar --retry 5 "$CURSOR_DOWNLOAD_URL"
    tar -xf "$CURSOR_FILENAME" -C .
    rm "$CURSOR_FILENAME"
fi
cd ~

# --- Update GTK settings files ---
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0

ini_gtk3=~/.config/gtk-3.0/settings.ini
mkdir -p "$(dirname "$ini_gtk3")"
if [ -f "$ini_gtk3" ]; then
    grep -q "gtk-theme-name" "$ini_gtk3" && \
        sed -i 's/^gtk-theme-name=.*/gtk-theme-name=rose-pine-gtk/' "$ini_gtk3" || \
        echo "gtk-theme-name=rose-pine-gtk" >> "$ini_gtk3"
    grep -q "gtk-icon-theme-name" "$ini_gtk3" && \
        sed -i 's/^gtk-icon-theme-name=.*/gtk-icon-theme-name=rose-pine-icons/' "$ini_gtk3" || \
        echo "gtk-icon-theme-name=rose-pine-icons" >> "$ini_gtk3"
    grep -q "gtk-cursor-theme-name" "$ini_gtk3" && \
        sed -i "s/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=$CURSOR_THEME_NAME/" "$ini_gtk3" || \
        echo "gtk-cursor-theme-name=$CURSOR_THEME_NAME" >> "$ini_gtk3"
else
    echo "[Settings]" > "$ini_gtk3"
    echo "gtk-theme-name=rose-pine-gtk" >> "$ini_gtk3"
    echo "gtk-icon-theme-name=rose-pine-icons" >> "$ini_gtk3"
    echo "gtk-cursor-theme-name=$CURSOR_THEME_NAME" >> "$ini_gtk3"
fi

ini_gtk4=~/.config/gtk-4.0/settings.ini
mkdir -p "$(dirname "$ini_gtk4")"
if [ -f "$ini_gtk4" ]; then
    grep -q "gtk-cursor-theme-name" "$ini_gtk4" && \
        sed -i "s/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=$CURSOR_THEME_NAME/" "$ini_gtk4" || \
        echo "gtk-cursor-theme-name=$CURSOR_THEME_NAME" >> "$ini_gtk4"
    grep -q "gtk-application-prefer-dark-theme" "$ini_gtk4" || echo "gtk-application-prefer-dark-theme=true" >> "$ini_gtk4"
else
    echo "[Settings]" > "$ini_gtk4"
    echo "gtk-cursor-theme-name=$CURSOR_THEME_NAME" >> "$ini_gtk4"
    echo "gtk-application-prefer-dark-theme=true" >> "$ini_gtk4"
fi

# --- Set cursor for X11/Wayland ---
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME_NAME" 2>/dev/null || true
grep -q "export XCURSOR_THEME=$CURSOR_THEME_NAME" ~/.profile || echo "export XCURSOR_THEME=$CURSOR_THEME_NAME" >> ~/.profile

# --- Update icon cache ---
gtk-update-icon-cache -f -t ~/.icons/rose-pine-icons || true
gtk-update-icon-cache -f -t "$CURSOR_INSTALL_DIR/$CURSOR_THEME_NAME" || true
# Set cursor for X11/Wayland
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME_NAME" 2>/dev/null || true
grep -q "export XCURSOR_THEME=$CURSOR_THEME_NAME" ~/.profile || echo "export XCURSOR_THEME=$CURSOR_THEME_NAME" >> ~/.profile

# Update icon cache
gtk-update-icon-cache -f ~/.icons/rose-pine-icons || true
gtk-update-icon-cache -f "$CURSOR_INSTALL_DIR/$CURSOR_THEME_NAME" || true


## General DE Stuff
yay -S --noconfirm --needed \
  wl-clipboard \
  brightnessctl \
  nwg-look \
  thunar \
  thunar-volman \
  cliphist \
  wezterm \

  ## wezterm term info
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wezterm/wezterm/main/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile


# Sway & Wayland Environment
yay -S --noconfirm --needed \
  sway \
  swaync \
  swaylock \
  swayidle \
  swaync \
  autotiling \
  grim \
  slurp \

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

## Browsers & Apps
yay -S --noconfirm --needed \
  firefox \
  spotify \
  zen-browser-bin \
  steam \
  surfshark-client \
  gimp 

  #set zen to default browser
 xdg-settings set default-web-browser zen-browser.desktop
 xdg-mime default zen-browser.desktop x-scheme-handler/http
 xdg-mime default zen-browser.desktop x-scheme-handler/https

 #set GIMP for default w/ images
 xdg-mime default gimp.desktop image/jpeg
 xdg-mime default gimp.desktop image/jpg
 xdg-mime default gimp.desktop image/gif
 xdg-mime default gimp.desktop image/bmp
 xdg-mime default gimp.desktop image/webp
 xdg-mime default gimp.desktop image/png

 # Docker setup
yay -S --noconfirm --needed\
  docker \
  docker-compose \

sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

## Flatpak
yay -S --noconfirm flatpak 

flatpak install flathub com.bitwarden.desktop

## Rofi & Menu
yay -S --noconfirm --needed \
  rofi-wayland \
  rofi-power-menu

## Ly (just in case)
yay -S --noconfirm --needed \
  ly

sudo systemctl enable ly.service

# 4. Optional: Clean up
yay -Sc --noconfirm

echo "All done! You may want to log out and back in, or reboot, to ensure all services are running."

