# Arch Linux Packages and Commands

## Base Linux

Install YAY or PARU for AUR
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
> upower
> auto-cpufreq
> fwupd

_Enable auto-cpufreq_

```
sudo systemctl enable --now auto-cpufreq
```

_Enable upower_

```
sudo systemctl enable --now upower.service
```

### Essential System Tools:

> base
> base-devel
> linux
> linux-firmware
> git
> networkmanager
> unzip

_Enable NetworkManager_

```
sudo systemctl enable --now NetworkManager.service
```

### Graphics:

> mesa
> lib32-mesa
> vulkan-radeon
> lib32-vulkan-radeon

### Sound & Bluetooth:

> pipewire
> pipewire-alsa
> pipewire-pulse
> pipewire-jack
> wireplumber
> alsa-utils
> pwvucontrol
> pamixer
> playerctl
> sof-firmware
> bluez
> bluez-utils
> blueman

_Enable Bluetooth_

```
sudo systemctl enable --now bluetooth.service
```

### Display Manager (Login Screen)

Currently I use Ly because it's simple and none flashy (This could be changed)

> grub
> efibootmgr

enable ly (this command has changed from previous iterations):

```
sudo systemctl enable ly@tty2.service
```

it requires a restart if you would like to ensure it works run

```
sudo systemctl enable --now ly@tty2.service
```

### Window Manager

I still bounce around currently using hyprland and add additional WM components if I change.

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
> docker
> docker-compose
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
> uv
> ripgrep
> starship
> tree

Language Stuff

> npm
> go
> zig
> rust
> cargo
> luarocks
> elixir
> deno
> jdk-openjdk
> jdk17-openjdk

_Language Servers_

> lua-language-server
> typescript
> typescript-language-server
> prettier
> gopls
> goimports
> gofumpt
> rust-analyzer
> yaml-language-server
> zls
> elixir-ls

Clone the TPM repo reload tmux config then Leader-I to install plugins

```

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

```

### Development Tools

> docker-compose
> emacs
> python
> python-pip
> stylua
> tree-sitter
> pyright
> python-black
> exercism-bin
> gparted

## Fonts

This is for google fonts, my prefered nerdfont, and a cool system font I like:

> noto-fonts
> noto-fonts-cjk
> noto-fonts-extra
> noto-fonts-emoji
> ttf-jetbrains-mono-nerd
> ttf-nerd-fonts-symbols
> ttf-nerd-fonts-symbols-common
> otf-nebula-sans

## Office

> libreoffice-fresh

## Internet & Others

Currently using Zen as main browser and Firefox for Widevine and DRM

> zen-browser-bin
> firefox

### Music

> spotify

### Note Taking

> obsidian

setting zen to default browser:

```
xdg-settings set default-web-browser zen-browser.desktop
xdg-mime default zen-browser.desktop x-scheme-handler/http
xdg-mime default zen-browser.desktop x-scheme-handler/https
```

For BitWarden

> flatpak

Then run:

```
flatpak install -y flathub com.bitwarden.desktop
```

For GIMP

> gimp

settings defaults:

```
xdg-mime default gimp.desktop image/jpeg
xdg-mime default gimp.desktop image/jpg
xdg-mime default gimp.desktop image/gif
xdg-mime default gimp.desktop image/bmp
xdg-mime default gimp.desktop image/webp
xdg-mime default gimp.desktop image/png

```
