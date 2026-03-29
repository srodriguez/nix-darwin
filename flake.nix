{
  description = "Seb nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew,homebrew-core, homebrew-cask,}:
  let
    configuration = { pkgs, ... }: {

      # Allow UnFree packages (e.g. obsidian)
      nixpkgs.config.allowUnfree = true;


      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

      system.primaryUser = "srodriguez";

      # See documentation : https://mynixos.com/
      # https://mynixos.com/nix-darwin/options
      # https://mynixos.com/nix-darwin/options/system.defaults
      system.defaults = {
        dock.autohide = true;
        dock.orientation = "right";
        #top right corner hot action : 4: Desktop
        dock.wvous-tr-corner = 4;
        dock.persistent-apps = [
          "/Applications/Nix Apps/Firefox.app"
          "/Applications/Nix Apps/WezTerm.app"
          "/Applications/Nix Apps/Obsidian.app"
          "/Applications/Nix Apps/Zotero.app"
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
      modules = [
        configuration 
        ./modules/terminal.nix
        ./modules/dev-common.nix
        ./modules/desktop-tools.nix
        ./modules/writing-research.nix
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "srodriguez";

            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
            };

            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = true;


            # Set nix-homebrew.autoMigrate = true; to allow nix-homebrew to migrate the installation
            # During auto-migration, nix-homebrew will delete the existing installation while keeping installed packages.
            autoMigrate = true;
          };
        }
      ];
    };
  };
}
