{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
    curl
    tree
    bat # better cat
    fd # Better find commnad
    yazi # file manager


    # Nvim and tools
    neovim
    ffmpegthumbnailer
    unar # unarchiving tool
    poppler #PDF rendering app
    fzf # fuzzy finder
    ripgrep # Grep tool (required by vim)
    zoxide # better cd
    delta # better diff tool for git
    tlrc # user-friendly man pages

    direnv # Enable flakes on directory entry
    cargo # need to build lsps

    # Terminal Emulators
    tmux
    wezterm
    kitty
  ];

   # Enable nix-direnv integration
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}

