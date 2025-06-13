#!/bin/bash

set -e

cd ~

# Update system
sudo dnf update -y

# install stow and pip for configs
sudo dnf install -y stow python3-pip

# Dotfiles and Stow (optional)
if [ -d ~/dotfiles ]; then
 cd ~/dotfiles
 rm -rf ~/.bashrc
 stow terminal tmux sway btop nvim rofi wezterm fastfetch starship tmux yazi
 cd ~
fi


# Bluetooth stack
sudo dnf install -y bluez bluez-tools bluez-libs blueman
sudo systemctl enable --now bluetooth

# ZRAM setup
sudo dnf install -y zram-generator
sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
EOF
sudo systemctl start systemd-zram-setup@zram0.service
echo "ZRAM status:"
swapon --show

# Sway and workflow dependencies
sudo dnf install -y sway swaylock swayidle swaybg pamixer playerctl upower brightnessctl network-manager-applet wl-clipboard grim slurp neovim entr tmux zsh fzf fd-find fastfetch rofi-wayland

# For fd to be available as 'fd' instead of 'fdfind'
if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
  sudo ln -sf $(which fdfind) /usr/local/bin/fd
fi

# Zsh plugins
sudo dnf install -y zsh-syntax-highlighting zsh-autosuggestions

# Dev tools
sudo dnf install -y golang rust cargo zig

# Deno
curl -fsSL https://deno.land/install.sh | sh

# Wayland and portals
# sudo dnf install -y wayland 
sudo dnf install -y xdg-desktop-portal xdg-desktop-portal-wlr

# Extra fonts
sudo dnf install -y fira-code-fonts fontawesome-fonts

# Nerd Fonts and Nebula Sans
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
unzip -o JetBrainsMono.zip
rm JetBrainsMono.zip
curl -LO https://nebulasans.com/download/NebulaSans-1.010.zip
unzip -o NebulaSans-1.010.zip
rm NebulaSans-1.010.zip 
fc-cache -fv

# Rose Pine GTK theme
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

# For autotiling (not in Fedora repos, install via pip)
if ! command -v autotiling &>/dev/null; then
  pip3 install --user autotiling
fi

# For auto-cpufreq (CPU frequency management, via GitHub installer)
if ! command -v auto-cpufreq &>/dev/null; then
  git clone https://github.com/AdnanHodzic/auto-cpufreq.git /tmp/auto-cpufreq
  cd /tmp/auto-cpufreq
  sudo ./auto-cpufreq-installer
  cd -
  rm -rf /tmp/auto-cpufreq
fi

# For bt-dualboot (Bluetooth dual boot helper, via pip)
if ! command -v bt-dualboot &>/dev/null; then
  pip3 install --user bt-dualboot
fi

# COPRS (for latest lazygit and yazi)
sudo dnf copr enable atim/lazygit -y
sudo dnf install -y lazygit
sudo dnf copr enable lihaohong/yazi -y
sudo dnf install -y yazi
sudo dnf copr enable wezfurlong/wezterm-nightly
sudo dnf install wezterm

tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wezterm/wezterm/main/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile

dnf copr enable atim/starship
dnf install starship


# Flatpak and Flathub setup
sudo dnf install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.spotify.Client app.zen_browser.zen com.surfshark.Surfshark com.saivert.pwvucontrol

# Change default shell to zsh for the current user
chsh -s $(which zsh) 

echo "All done! You may want to log out and back in, or reboot, to ensure all services are running."

