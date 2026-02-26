# NixOS Migration Guide

## Overview

Complete NixOS configuration migrated from your Arch Linux/CachyOS setup with flakes and Home Manager integration.

## Directory Structure

```
nix/
├── flake.nix                      # Main flake definition with Home Manager
├── configuration.nix              # System-wide configuration and packages
├── home.nix                      # User-specific configuration and dotfile symlinks
├── hosts/
│   └── squishy/
│       └── hardware-configuration.nix  # Hardware-specific config (UPDATE THIS)
├── install.sh                    # Quick install script
├── PACKAGES_NOTES.md             # Notes on packages needing special handling
└── README.md                     # This file
```

## Installation Steps

### 1. Boot NixOS Installer

Download and boot the NixOS installer ISO.

### 2. Generate Hardware Configuration

After partitioning and mounting to `/mnt`:

```bash
sudo nixos-generate-config --root /mnt
sudo cp /mnt/etc/nixos/hardware-configuration.nix /home/dallas/dotfiles/nix/hosts/squishy/hardware-configuration.nix
```

### 3. Build System

From the nix directory:

```bash
sudo nixos-rebuild switch --flake .#squishy
```

Or use the included script:

```bash
sudo ./install.sh
```

### 4. Post-Installation

After first boot:

```bash
# Clone TPM for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install BitWarden
flatpak install -y flathub com.bitwarden.desktop

# Press prefix+I in tmux to install plugins
```

## Key Features

### System Packages (configuration.nix)
- **WM**: Hyprland ecosystem
- **Gaming**: Steam, Heroic, Prismlauncher
- **Development**: Multiple languages, LSPs, editors
- **System**: Docker, Flatpak, auto-cpufreq
- **Audio**: PipeWire with Bluetooth

### User Configuration (home.nix)
- zsh with starship prompt
- Dotfile symlinks from your dotfiles repo
- User-specific packages
- Git configuration

### Hardware Configuration
- AMD GPU support with Vulkan
- Bluetooth
- Audio with PipeWire
- Power management

## Managing Configuration

### Update System

```bash
sudo nixos-rebuild switch --flake .#squishy
```

### Update Home Manager

```bash
home-manager switch --flake .#squishy
```

### Update Flake Lock

```bash
nix flake update
```

### Test Changes Without Applying

```bash
sudo nixos-rebuild test --flake .#squishy
```

## Packages Requiring Manual Setup

See `PACKAGES_NOTES.md` for details:
- Mullvad VPN (use NUR or build manually)
- Zen Browser (not in Nixpkgs)
- Nebula Sans font (install manually)
- Steam VPN desktop file (copy from notes)

## Rollbacks

NixOS automatically keeps previous generations:

```bash
# List generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Switch to specific generation
sudo nix-env --switch-generation <number> --profile /nix/var/nix/profiles/system
```

## Troubleshooting

### Build Errors

Check package names and update flake:
```bash
nix flake update
sudo nixos-rebuild switch --flake .#squishy
```

### Graphics Issues

Check hardware-configuration.nix and ensure AMD drivers are loaded:
```bash
lspci -k | grep -A 2 -i vga
```

### Sound Issues

Verify PipeWire services:
```bash
systemctl --user status pipewire pipewire-pulse wireplumber
```

## Next Steps

1. Copy actual hardware-configuration.nix from NixOS installer
2. Update user email in home.nix (line 38)
3. Add any missing packages as needed
4. Test all applications work correctly
5. Customize Hyprland and Waybar configs if needed
