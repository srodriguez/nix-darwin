
{ pkgs, ... }: {

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
          "/System/Applications/Reminders.app"
          "/Applications/Microsoft Teams.app"
          "/Applications/Nix Apps/Obsidian.app"
          "/Applications/Nix Apps/Zotero.app"
        ];

        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;

      };

}

