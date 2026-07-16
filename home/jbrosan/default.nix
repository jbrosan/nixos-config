{ pkgs, ... }:

{
  home.username = "jbrosan";
  home.homeDirectory = "/home/jbrosan";

  # Keep this at the version where Home Manager is first introduced.
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    eza
    fastfetch
  ];

  programs.home-manager.enable = true;
}

