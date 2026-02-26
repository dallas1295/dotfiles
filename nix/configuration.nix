{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "squishy";
  networking.networkmanager.enable = true;

  time.timeZone = "UTC";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.dallas = {
    isNormalUser = true;
    description = "dallas";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" ];
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    mesa
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
  ];
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.mesa
    driversi686Linux.vulkan-loader
    driversi686Linux.vulkan-validation-layers
    driversi686Linux.vulkan-extension-layer
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.auto-cpufreq.enable = true;

  services.xserver.enable = true;
  services.displayManager.ly.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts
    jetbrains-mono
  ];

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "JetBrains Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };

  environment.systemPackages = with pkgs; [
    git
    networkmanager
    ntfs3g
    udisks2
    reflector
    fwupd
    amd-ucode
    sof-firmware

    hyprland
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    rofi
    rofi-power-menu
    cliphist
    brightnessctl
    thunar
    wl-clipboard
    waybar
    swaync
    yazi
    autotiling-rs
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    polkit_gnome

    steam
    heroic
    prismlauncher
    gamemode
    mangohud

    ghostty
    tmux
    zoxide
    lsd
    fd
    tree
    fzf
    neovim
    lazygit
    gh
    stow

    zsh
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
    starship

    fastfetch
    btop
    pamixer

    entr
    p7zip
    openbsd-netcat

    ollama

    stylua
    pyright
    black
    uv

    nodejs
    go
    zig
    luarocks
    elixir
    deno
    jdk
    jdk17
    python3
    python312Packages.pip
    typescript
    rustup

    lua-language-server
    typescript-language-server
    prettier
    gopls
    gofumpt
    rust-analyzer
    yaml-language-server
    zls
    elixir_ls
    vscode-langservers-extracted

    brave
    firefox

    spotify

    libreoffice-fresh
    obsidian

    flatpak

    bluez
    bluez-tools

    alsa-utils
    pavucontrol

    nftables
    gparted

    qt5-wayland
    qt6-wayland
  ];

  programs.zsh.enable = true;

  services.flatpak.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "24.11";

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  security.polkit.enable = true;

  programs.dconf.enable = true;

  services.openssh.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
