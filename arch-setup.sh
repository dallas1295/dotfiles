#!/bin/bash

set -e

cd ~

# 1. Install git if not already present 

sudo pacman -Syu --needed git

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

git clone https://github.com/dallas1295/dotfiles

if [ -d ~/dotfiles ]; then
 cd ~/dotfiles
 rm -rf ~/.bashrc
 stow terminal tmux sway btop nvim rofi wezterm fastfetch starship tmux yazi
 cd ~
fi

# 3. Install packages by category

## System & Core Utilities
paru -S --noconfirm --needed\
  pacman-contrib \
  zram-generator \
  tree \
  upower \
  reflector \
  reflector-simple \

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

sudo systemctl enable --now bluetooth

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
  rust \
  cargo \
  neovim \
  tmux \
  fd \
  fzf \
  entr

  # Deno
  curl -fsSL https://deno.land/install.sh | sh

## Fonts & Themes
paru -S --noconfirm --needed \
  xdg-desktop-portal \
  xdg-desktop-portal-wlr \
  otf-nebula-sans \
  ttf-font-awesome \
  ttf-jetbrains-mono-nerd \

# Rose Pine theming
mkdir -p ~/.themes
cd ~/.themes
if [ ! -d "rose-pine-gtk" ]; then
    curl -fLO --progress-bar --retry 5 https://github.com/rose-pine/gtk/releases/latest/download/gtk3.tar.gz
    curl -fLO --progress-bar --retry 5 https://github.com/rose-pine/gtk/releases/latest/download/gtk4.tar.gz
    mkdir -p rose-pine-gtk
    tar -xzf gtk3.tar.gz -C rose-pine-gtk --strip-components=1
    rm gtk3.tar.gz
    tar -xzf gtk4.tar.gz -C rose-pine-gtk --strip-components=1
    rm gtk4.tar.gz
fi

cd ~

# Rose Pine Icons
mkdir -p ~/.icons
cd ~/.icons
if [ ! -d "rose-pine-icons" ]; then
    curl -fLO --progress-bar --retry 5 https://github.com/rose-pine/gtk/releases/latest/download/rose-pine-icons.tar.gz
    tar -xzf rose-pine-icons.tar.gz -C .
    rm rose-pine-icons.tar.gz
fi
cd ~

# Rose Pine Cursor
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

# Update GTK settings
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
for ini in ~/.config/gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini; do
    mkdir -p "$(dirname "$ini")"
    if [ -f "$ini" ]; then
        grep -q "gtk-theme-name" "$ini" && \
            sed -i 's/^gtk-theme-name=.*/gtk-theme-name=rose-pine-gtk/' "$ini" || \
            echo "gtk-theme-name=rose-pine-gtk" >> "$ini"
        grep -q "gtk-icon-theme-name" "$ini" && \
            sed -i 's/^gtk-icon-theme-name=.*/gtk-icon-theme-name=rose-pine-icons/' "$ini" || \
            echo "gtk-icon-theme-name=rose-pine-icons" >> "$ini"
        grep -q "gtk-cursor-theme-name" "$ini" && \
            sed -i "s/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=$CURSOR_THEME_NAME/" "$ini" || \
            echo "gtk-cursor-theme-name=$CURSOR_THEME_NAME" >> "$ini"
    else
        echo "[Settings]" > "$ini"
        echo "gtk-theme-name=rose-pine-gtk" >> "$ini"
        echo "gtk-icon-theme-name=rose-pine-icons" >> "$ini"
        echo "gtk-cursor-theme-name=$CURSOR_THEME_NAME" >> "$ini"
    fi
done

# Set cursor for X11/Wayland
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME_NAME" 2>/dev/null || true
grep -q "export XCURSOR_THEME=$CURSOR_THEME_NAME" ~/.profile || echo "export XCURSOR_THEME=$CURSOR_THEME_NAME" >> ~/.profile

# Update icon cache
gtk-update-icon-cache -f ~/.icons/rose-pine-icons || true
gtk-update-icon-cache -f "$CURSOR_INSTALL_DIR/$CURSOR_THEME_NAME" || true


  
## Sway & Wayland Environment
paru -S --noconfirm --needed \
  wl-clipboard \
  sway \
  swaync \
  autotiling \
  pamixer \
  flameshot \
  pwvucontrol \
  nwg-look \
  cliphist \
  wezterm

## Audio, Bluetooth, and Power
paru -S --noconfirm --needed \
  pipewire \
  pipewire-alsa \
  pipewire-pulseaudio \
  pipewire-jack \
  wireplumber \
  alsa-utils \
  pwvucontrol \
  blueman \
  auto-cpufreq \
  bt-dualboot

sudo systemctl enable --now bluetooth.service
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
  rofi-wayland \
  rofi-power-menu

## Ly (just in case)
paru -S --noconfirm --needed \
  ly

sudo systemctl enable ly.service

# 4. Optional: Clean up
paru -Sc --noconfirm

echo "All done! You may want to log out and back in, or reboot, to ensure all services are running."

