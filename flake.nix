{
  description = "Seb nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # Allow UnFree packages (e.g. obsidian)
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.neovim
          pkgs.obsidian
          pkgs.cargo # need to build lsps
        ];

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

      system.primaryUser = "srodriguez";

      # See documentation : https://mynixos.com/
      # https://mynixos.com/nix-darwin/options
      # https://mynixos.com/nix-darwin/options/system.defaults
      system.defaults = {
        dock.autohide = true;
#top right corner hot action : 4: Desktop
        dock.wvous-tr-corner = 4;
        dock.persistent-apps = [
        #"${pkgs.obsidian}/Applications/Obsidian.app"
        "/Applications/Nix Apps/Obsidian.app"

        ];

        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;

      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#MB14
    darwinConfigurations."MB14" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
