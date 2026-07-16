{ pkgs, ... }:

{
  home.username = "jbrosan";
  home.homeDirectory = "/home/jbrosan";

  # Keep this at the version where Home Manager is first introduced.
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    eza
    fastfetch
    htop
  ];

  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  programs.fish.enable = true;
  xdg.configFile."ghostty/config".source = ./ghostty/config;
  xdg.configFile."ghostty/shaders/trail.glsl".source = ./ghostty/shaders/trail.glsl;
  xdg.configFile."ghostty/shaders/cursor_frozen.glsl".source = ./ghostty/shaders/cursor_frozen.glsl;
  programs.ghostty.enable = true;
  programs.ripgrep.enable = true;
  programs.yazi.enable = true;
  programs.zoxide.enable = true;
  programs.home-manager.enable = true;
}

