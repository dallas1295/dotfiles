# Arch Linux Packages and Commands

## Base Linux

Install Dotfiles

> paru
> paru-debug

### Add multilib

```
sudo nvim /etc/pacman.conf
```

and uncomment multilib lines

### For Arch Mirrors & PC Tuning:

> reflector
> reflector-simple
> auto-cpufreq
> fwupd

_Enable auto-cpufreq_

```
sudo systemctl enable --now auto-cpufreq
```

### Essential System Tools:

> base
> base-devel
> linux
> linux-firmware
> git
> networkmanager
> ntfs-3g

_Enable NetworkManager_

```
sudo systemctl enable --now NetworkManager.service
```

### Graphics:

> lib32-mesa
> vulkan-radeon
> lib32-vulkan-radeon
> qt5-wayland
> qt6-wayland

### Sound & Bluetooth:

> pipewire-alsa
> pipewire-pulse
> alsa-utils
> pwvucontrol
> pamixer
> sof-firmware
> bluez
> blueman

_Enable Bluetooth_

```
sudo systemctl enable --now bluetooth.service
```

### Display Manager (Login Screen)

> grub
> efibootmgr
> os-prober

enable ly (this command has changed from previous iterations):

```
sudo systemctl enable ly@tty2.service
```

### Window Manager

> hyprland
> hyprlock
> hypridle
> hyprpaper
> hyprshot
> hyprpicker
> hyprpolkitagent
> xdg-desktop-portal
> xdg-desktop-portal-hyprland
> rofi-power-menu
> rofi
> cliphist
> brightnessctl
> thunar
> thunar-volman
> wl-clipboard
> nwg-look
> waybar
> swaync
> yazi
> autotiling

### Gaming

> steam
> heroic-games-launcher-bin
> gamemode
> mangohud

## Terminal Things

_CHINA_

> mullvad-vpn-bin

Main Essentials/CLI tools:

> ghostty
> stow
> tmux
> lazygit
> github-cli
> neovim
> helix
> zsh
> zsh-completions
> zsh-syntax-highlighting
> fd
> fzf
> entr
> zoxide
> lsd
> starship
> tree
> fastfetch
> btop
> ollama

Language Stuff

> npm
> go
> zig
> luarocks
> elixir
> deno
> jdk-openjdk
> jdk17-openjdk
> python-pip
> python-pipx

_Language Servers_

> lua-language-server
> typescript-language-server
> prettier
> gopls
> gofumpt
> rust-analyzer
> yaml-language-server
> zls
> elixir-ls
> vscode-css-languageserver
> vscode-html-languageserver
> vscode-json-languageserver

Clone the TPM repo reload tmux config then Leader-I to install plugins

```

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

```

### Development Tools

> stylua
> pyright
> python-black
> exercism-bin
> gparted

## Fonts

> noto-fonts-cjk
> noto-fonts-extra
> ttf-jetbrains-mono-nerd
> otf-nebula-sans

## Office

> libreoffice-fresh

## Internet & Others

> brave-bin
> firefox

### Music

> spotify

### Note Taking

> obsidian

### Flatpak

> flatpak

For BitWarden

```
flatpak install -y flathub com.bitwarden.desktop
```
