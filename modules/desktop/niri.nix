{ pkgs, ... }:

{
  programs.niri.enable = true;

  # Keep the existing OpenSSH agent; GNOME Keyring remains available for portals.
  services.gnome.gcr-ssh-agent.enable = false;

  # Niri launches Xwayland Satellite automatically when an X11 client connects.
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
}
