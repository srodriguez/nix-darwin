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
    git-delta # better diff tool
    tlrc # user-friendly man pages
  ];
}

