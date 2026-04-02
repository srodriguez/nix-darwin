{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.colima
    pkgs.docker # Required for the Docker CLI to work with Colima
    pkgs.docker-compose
  ];


launchd.user.agents.colima = {

  command = "${pkgs.colima}/bin/colima start --foreground";
  serviceConfig = {
    KeepAlive = true;
    RunAtLoad = true;
    StandardOutPath = "/tmp/colima.out.log";
    StandardErrorPath = "/tmp/colima.err.log";
  };
};
}

