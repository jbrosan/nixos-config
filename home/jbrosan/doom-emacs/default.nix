{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
  };

  home.packages = with pkgs; [
    bash
    cmake
    gcc
    gnumake
    libtool
    pkg-config
    shellcheck
    multimarkdown

    nodejs
    typescript
    typescript-language-server
    vscode-langservers-extracted
    eslint

    go
    gopls
    delve
    gofumpt
    golangci-lint

    rust-analyzer

    nixd
    nil

    # Doom doctor tooling
    direnv
    libxml2
    nixfmt
    shfmt
    html-tidy
    stylelint
    js-beautify
    gomodifytags
    gotests
    gore
    editorconfig-core-c
  ];

  home.sessionPath = [
    "${config.xdg.configHome}/emacs/bin"
  ];

  xdg.configFile = {
    "doom/init.el" = {
      source = ./doom/init.el;
      force = true;
    };

    "doom/config.el" = {
      source = ./doom/config.el;
      force = true;
    };

    "doom/packages.el" = {
      source = ./doom/packages.el;
      force = true;
    };
  };

  home.activation.doomSyncNotice =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -x "$HOME/.config/emacs/bin/doom" ]; then
        echo "Doom configuration changed; run: doom sync"
      fi
    '';
}
