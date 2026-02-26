# NixOS Configuration

This directory contains a flake-based NixOS configuration for rebuilding your CachyOS system to NixOS with all packages from your Arch Linux setup.

## Initial Setup

1. Install Nix on your CachyOS system:
   ```bash
   curl -L https://nixos.org/nix/install | sh -s -- --daemon
   ```

2. Enable flakes:
   ```bash
   mkdir -p ~/.config/nix
   echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
   ```

3. Reboot or restart your shell

## Generating Hardware Configuration

When you boot into NixOS installer, generate hardware configuration:
```bash
sudo nixos-generate-config --root /mnt
```

Then copy `/mnt/etc/nixos/hardware-configuration.nix` to `hosts/squishy/hardware-configuration.nix`

## Building and Switching

From this directory:
```bash
sudo nixos-rebuild switch --flake .#squishy
```

## Testing Changes

Test without applying:
```bash
sudo nixos-rebuild test --flake .#squishy
```

## Home Manager

Home Manager is integrated for user-specific configuration and dotfile symlinking. User packages and configs are in `home.nix`.

## Included Packages

- **Window Manager**: Hyprland with all utilities (hyprlock, hypridle, waybar, rofi, etc.)
- **Gaming**: Steam, Heroic, Prismlauncher, gamemode, mangohud
- **Terminal**: Ghostty, tmux, zsh with starship, various CLI tools
- **Development**: Neovim, git, multiple languages (Go, Rust, Node, Elixir, etc.), LSPs
- **Audio/Bluetooth**: PipeWire, BlueZ, Blueman
- **Display Manager**: Ly
- **System**: auto-cpufreq, Docker, Flatpak, NetworkManager

## Host Specific Configuration

Add host-specific configurations in `hosts/squishy/` directory.
