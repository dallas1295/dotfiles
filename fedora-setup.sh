#!/bin/bash

set -e

cd ~

# Update system
sudo dnf update -y

# Dotfiles and Stow (optional)
if [ -d ~/dotfiles ]; then
  cd ~/dotfiles
  stow terminal tmux sway btop nvim rofi wezterm fastfetch starship tmux yazi
  cd ~
fi

# Audio stack
sudo dnf install -y pipewire pipewire-alsa pipewire-pulseaudio pipewire-jack wireplumber alsa-utils pwvucontrol

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
sudo dnf install -y sway swaylock swayidle swaybg pamixer playerctl upower brightnessctl network-manager-applet wl-clipboard grim slurp neovim entr tmux zsh fzf fd-find wezterm fastfetch

# For fd to be available as 'fd' instead of 'fdfind'
if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
  sudo ln -sf $(which fdfind) /usr/local/bin/fd
fi

# Zsh plugins
sudo dnf install -y zsh-syntax-highlighting zsh-autosuggestions

# Dev tools
sudo dnf install -y golang rust

# Wayland and portals
sudo dnf install -y wayland xdg-desktop-portal xdg-desktop-portal-wlr

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
cd ~

# Rose Pine GTK theme
mkdir -p ~/.themes
cd ~/.themes
if [ ! -d "rose-pine-gtk" ]; then
  curl -LO https://github.com/rose-pine/gtk/releases/latest/download/rose-pine-gtk.zip
  unzip -o rose-pine-gtk.zip -d rose-pine-gtk
  rm rose-pine-gtk.zip
fi
cd ~

# Rose Pine cursor
mkdir -p ~/.icons
cd ~/.icons
if [ ! -d "rose-pine-cursor" ]; then
  curl -LO https://github.com/rose-pine/cursor/releases/latest/download/rose-pine-cursor.zip
  unzip -o rose-pine-cursor.zip -d rose-pine-cursor
  rm rose-pine-cursor.zip
fi
cd ~

# Update GTK settings
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
for ini in ~/.config/gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini; do
  grep -q "gtk-theme-name" "$ini" && \
    sed -i 's/^gtk-theme-name=.*/gtk-theme-name=rose-pine-gtk/' "$ini" || \
    echo "gtk-theme-name=rose-pine-gtk" >> "$ini"
  grep -q "gtk-cursor-theme-name" "$ini" && \
    sed -i 's/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=rose-pine-cursor/' "$ini" || \
    echo "gtk-cursor-theme-name=rose-pine-cursor" >> "$ini"
done

# Set cursor for X11/Wayland
gsettings set org.gnome.desktop.interface cursor-theme 'rose-pine-cursor' 2>/dev/null || true
echo "export XCURSOR_THEME=rose-pine-cursor" >> ~/.profile

# Update icon cache
gtk-update-icon-cache ~/.icons/rose-pine-cursor || true

# For cliphist (clipboard history) - not in Fedora repos, install via cargo
if ! command -v cliphist &>/dev/null; then
  cargo install cliphist
fi

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

# Flatpak and Flathub setup
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.spotify.Client app.zen_browser.zen com.surfshark.Surfshark

# Change default shell to zsh for the current user
chsh -s $(which zsh) 

# Ly display manager
sudo dnf copr enable huulivoide/ly -y
sudo dnf install -y ly
sudo systemctl disable sddm.service || true
sudo systemctl disable gdm.service || true
sudo systemctl enable ly.service
sudo systemctl set-default graphical.target

echo "All done! You may want to log out and back in, or reboot, to ensure all services are running."

