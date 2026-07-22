{ ... }:

{
  imports = [
    ./appearance.nix
    ./kwin.nix
  ];

  # Plasma Manager starts in additive mode. Settings not declared here
  # remain controlled by KDE until they are deliberately migrated.
  programs.plasma.enable = true;
}
