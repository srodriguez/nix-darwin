
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    obsidian
    zotero
    drawio
  ];
}
