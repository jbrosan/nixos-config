{ ... }:

{
  # Enable the modern Nix command and flakes.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}

