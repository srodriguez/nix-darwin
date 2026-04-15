
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox-bin
  ];


  homebrew = {
    enable = true;
    #This will delete all other apps not installed via nix
    # onActivation.cleanup = "zap";
    casks = [
      "dockdoor"
    ];

    masApps = {
      #https://apps.apple.com/au/app/amphetamine/id937984704?mt=12
      "Amphetamine" = 937984704;
    };
  };
}

