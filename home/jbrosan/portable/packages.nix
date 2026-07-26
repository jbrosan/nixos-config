{ pkgs, ... }:

{
  # Cross-distribution user tools. This module intentionally manages no
  # shell, editor, terminal, compositor, or desktop configuration files.
  home.packages = with pkgs; [
    bat
    btop
    choose
    eza
    fastfetch
    fd
    fzf
    htop
    hyperfine
    jq
    ripgrep
    sd
    tree
    yazi
    yq-go
    zoxide
  ];
}
