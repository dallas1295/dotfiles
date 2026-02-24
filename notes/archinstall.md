# Arch Linux Packages and Commands

## Base Linux

Install AUR helper:

> paru

### Add multilib

```
sudo nvim /etc/pacman.conf
```

Uncomment multilib lines

### System Essentials:

> amd-ucode
> base-devel
> linux
> linux-firmware
> sof-firmware
> git
> networkmanager
> ntfs-3g
> udisks2
> udisks2-btrfs

_Enable NetworkManager_

```
sudo systemctl enable --now NetworkManager.service
```

### Power Management & Tuning:

> reflector
> reflector-simple
> auto-cpufreq
> fwupd

_Enable auto-cpufreq_

```
sudo systemctl enable --now auto-cpufreq.service
```

### Graphics:

> lib32-mesa
> vulkan-radeon
> lib32-vulkan-radeon
> openal
> lib32-openal

### Sound & Bluetooth:

> pipewire-alsa
> pipewire-pulse
> alsa-utils
> pwvucontrol
> pamixer
> bluez
> blueman

_Enable Bluetooth_

```
sudo systemctl enable --now bluetooth.service
```

### Boot & Display Manager:

> grub
> efibootmgr
> os-prober
> ly

_Enable ly on tty2_

```
sudo systemctl enable ly@tty2.service
```

_Then quickly edit the grub config (and mount windows if dual-boot)_

```
sudo nvim /etc/default/grub

// Then compile grub config

sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## Window Manager (Hyprland)

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
> wl-clipboard
> nwg-look
> waybar
> swaync
> yazi
> autotiling
> quickshell

### Theming:

> gruvbox-gtk-theme-git

## Gaming

> steam
> heroic-games-launcher-bin
> hytale-launcher-bin
> prismlauncher
> gamemode

add vpn passthrough .desktop for steam

```
cp /dotfiles/notes/Steam\ (No\ VPN).desktop   ~/.local/share/applications/
```

## Terminal & CLI Tools

### VPN:

> mullvad-vpn

### Terminal Emulator & Multiplexer:

> ghostty
> tmux

### File Management & Navigation:

> yazi
> zoxide
> lsd
> fd
> tree
> fzf

### Editors & Version Control:

> neovim
> lazygit
> github-cli
> stow

### Shell & Prompt:

> zsh
> zsh-completions
> zsh-autosuggestions
> zsh-syntax-highlighting
> starship

### System Monitoring & Utilities:

> fastfetch
> btop
> brightnessctl
> pamixer

### Other Utilities:

> entr
> 7zip
> openbsd-netcat

### AI/ML:

> ollama
> opencode

### Development Tools:

> stylua
> pyright
> python-black
> uv

## Programming Languages

> npm
> go
> zig
> luarocks
> elixir
> deno
> jdk-openjdk
> jdk17-openjdk
> python-pip
> typescript
> rustup

## Language Servers

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

### Clone TPM for tmux plugins:

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then reload tmux config and press `prefix + I` to install plugins

## Fonts

> noto-fonts-cjk
> noto-fonts-emoji
> noto-fonts-extra
> ttf-jetbrains-mono-nerd
> otf-nebula-sans

## Office & Productivity

> libreoffice-fresh
> obsidian

## Browsers

> brave-bin
> firefox
> zen-browser-bin

## Music

> spotify

## Flatpak

> flatpak

Install BitWarden:

```
flatpak install -y flathub com.bitwarden.desktop
```

## File System Utilities

> nftables
