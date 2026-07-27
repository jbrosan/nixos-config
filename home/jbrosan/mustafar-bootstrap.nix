{ ... }:

{
  imports = [
    ./portable/packages.nix
    ./portable/shell.nix
    ./portable/terminal.nix
    ./doom-emacs
    ./vader-glass
  ];

  home.username = "jbrosan";
  home.homeDirectory = "/home/jbrosan";

  # Keep this at the version where Home Manager is first introduced.
  home.stateVersion = "26.05";

  # Bootstrap only. Add user capabilities after collision review.
  programs.home-manager.enable = true;
}
