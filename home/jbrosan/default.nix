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

  programs.bat.enable = true;
  programs.zoxide.enable = true;
  programs.home-manager.enable = true;
}

