# Arch Linux Packages and Commands

## Base Linux

Install YAY or PARU for AUR
Install Dotfiles

### For Arch Mirros & PC Tuning:

> reflector
> reflector-simple (GUI app)
> upower
> auto-cpufreq
> fwpupdmgr

_Enable auto-cpufreq_

```
sudo systemctl enable --now auto-cpufreq
```

_Enable upower_

```
sudo systemctl enable --now upower.service
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
> bluez
> bluez-utils
> blueman

_Enable Bluetooth_

```
sudo systemctl enable --now bluetooth.service
```

### Display Manager (Login Screen)

Currently I use Ly because it's simple and none flashy (This could be changed)

> ly

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
> dunst
> rofi-power-menu
> rofi-wayland
> cliphist
> brightnessctl
> thunar
> thunar-volman
> wl-clipboard
> nwg-look
> waybar

## Terminal Things

_CHINA_

mullvad-vpn

Main Essentials/CLI tools:

> ghostty
> stow
> tmux
> lazygit
> docker
> docker-compose
> github-cli
> neovim
> zsh
> zsh-autocompletions
> zsh-syntax-highlightingA
> fd
> fzf
> entr
> zoxide

Language Stuff

> npm
> go
> zig
> rust
> cargo
> luarocks
> elixir

_Language Servers_
lua-language-server

### External Require Packages

```

# NPM Essentials

sudo npm install -g typescript typescript-language-server
sudo npm install -g @tailwindcss/language-server
sudo npm install -g prettier

curl -fsSL https://deno.land/install.sh | sh

# Go Lang Essentials

go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest

```

Clone the TPM repo reload tmux config then Leader-I to install plugins

```

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

```

## Fonts

This is for google fonts, my prefered nerdfont, and a cool system font I like:

> noto-fonts
> noto-fonts-cjk
> noto-fonts-extra
> noto-fonts-emoji
> ttf-jetbrains-mono-git
> otf-nebula-sans

## Internet & Others

Currently using Zen as main browser and Firefox for Widevine and DRM

> zen-browser-bin
> firefox

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
