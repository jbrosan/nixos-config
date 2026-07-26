{ ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      ga = "git add";
      gc = "git commit";
      gd = "git --no-pager diff";
      gl = "git --no-pager log --oneline --decorate -n 10";
      gs = "git --no-pager status --short --branch";
      nfc = "nix flake check";
    };

    interactiveShellInit = ''
      # Preserve CachyOS conveniences when present without making the
      # portable profile depend on CachyOS.
      if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
        source /usr/share/cachyos-fish-config/cachyos-config.fish
      end
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = builtins.fromTOML (
      builtins.readFile ../starship/starship.toml
    );
  };
}
