{ config, pkgs, ... }:

{
  home.username = "dallas";
  home.homeDirectory = "/home/dallas";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    hyprshot
    hyprpolkitagent
    nwg-look

    exercism
    helix

    zsh-fast-syntax-highlighting
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ];
    };
    initExtra = ''
      eval "$(starship init zsh)"
    '';
  };

  programs.git = {
    enable = true;
    userName = "dallas";
    userEmail = "dallas@local";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/hypr/.config";
      recursive = true;
    };
    ".config/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/waybar/.config";
      recursive = true;
    };
    ".config/swaync" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/swaync/.config";
      recursive = true;
    };
    ".config/rofi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/rofi/.config";
      recursive = true;
    };
    ".config/ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/ghostty/.config";
      recursive = true;
    };
    ".config/helix" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/helix/.config";
      recursive = true;
    };
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/nvim/.config";
      recursive = true;
    };
    ".config/btop" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/btop/.config";
      recursive = true;
    };
    ".config/fastfetch" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/fastfetch/.config";
      recursive = true;
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/kitty/.config";
      recursive = true;
    };
    ".tmux.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/tmux/.tmux.conf";
    };
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/terminal/.zshrc";
    };
    ".bashrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/terminal/.bashrc";
    };
    ".gitconfig" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/git/.gitconfig";
    };
    ".config/yazi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/yazi/.config";
      recursive = true;
    };
    ".config/zellij" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/zellij/.config";
      recursive = true;
    };
    ".config/aerospace" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/dallas/dotfiles/aerospace/.config";
      recursive = true;
    };
  };
}
