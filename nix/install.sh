#!/usr/bin/env bash
set -e

echo "Setting up NixOS from CachyOS..."

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

echo "Updating flake inputs..."
nix flake update

echo "Building system..."
nixos-rebuild switch --flake .#squishy

echo "System rebuilt successfully!"
echo ""
echo "Post-installation steps:"
echo "1. Install TPM for tmux: git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
echo "2. Install BitWarden: flatpak install -y flathub com.bitwarden.desktop"
echo "3. Steam VPN: Copy Steam (No VPN).desktop to ~/.local/share/applications/"
echo "4. Reboot to apply all changes"
