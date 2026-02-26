# Packages requiring special handling

These packages from your Arch Linux setup need alternative approaches in NixOS:

## AUR Packages (need alternative Nix expressions)

- `mullvad-vpn-bin` → Use `mullvad-vpn` from Nixpkgs or NUR
- `brave-bin` → Use `brave` from Nixpkgs
- `zen-browser-bin` → Not in Nixpkgs, use Firefox or build from source
- `hytale-launcher-bin` → Not available, may need manual installation
- `gruvbox-gtk-theme-git` → Use GTK themes from Nixpkgs or NUR
- `opencode` → CLI tool, may need to install separately

## Flatpak Apps

These should be installed via Flatpak:

```bash
flatpak install -y flathub com.bitwarden.desktop
```

## Language Servers

Most LSPs are available in Nixpkgs:
- `lua-language-server`
- `typescript-language-server`
- `gopls`
- `rust-analyzer`
- `zls`
- `elixir_ls`
- `yaml-language-server`
- `vscode-langservers-extracted` (includes CSS, HTML, JSON LS)

## Fonts

- `ttf-jetbrains-mono-nerd` → Use `jetbrains-mono` from Nixpkgs (includes Nerd Font symbols)
- `otf-nebula-sans` → Not in Nixpkgs, may need to add manually

## Manual Configuration Needed

1. TPM for tmux:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

2. Steam VPN passthrough: Copy `.desktop` file to `~/.local/share/applications/`

3. Hyprland config: Symlink from dotfiles via Home Manager

4. GPU drivers: AMD configuration included, verify in hardware-configuration.nix

## Development Tools

- `paru` (AUR helper) → Not needed in NixOS, use `nix-search` and `nix-env` or `nix shell`
- `python-black` → Use `black` from Nixpkgs
- `python-pipx` → Use `pipx` from Nixpkgs
