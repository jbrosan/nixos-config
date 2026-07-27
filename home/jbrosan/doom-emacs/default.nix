{ config, lib, pkgs, ... }:

let
  treesitGrammars = pkgs.emacsPackages.treesit-grammars.with-grammars (
    grammars: with grammars; [
      tree-sitter-bash
      tree-sitter-css
      tree-sitter-go
      tree-sitter-javascript
      tree-sitter-json
      tree-sitter-nix
      tree-sitter-python
      tree-sitter-rust
      tree-sitter-typescript
      tree-sitter-tsx
      tree-sitter-yaml
    ]
  );

  emacsWrapped = pkgs.symlinkJoin {
    name = "emacs30-pgtk-portable";
    paths = [ pkgs.emacs30-pgtk ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/emacs"         --set FONTCONFIG_FILE "/home/jbrosan/.config/fontconfig/emacs-fontconfig.conf"         --set EMACS_TREE_SITTER_GRAMMAR_PATH "${treesitGrammars}/lib"         --set GTK_MODULES ""
    '';
  };
in
{
  # Expose Nix-managed fonts to host applications on non-NixOS systems.
  fonts.fontconfig.enable = true;

  programs.emacs = {
    enable = true;
    package = emacsWrapped;
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

    # Doom icon and symbol coverage
    nerd-fonts.symbols-only
    nerd-fonts.caskaydia-cove
    inter
    ubuntu-classic
    treesitGrammars

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
    "fontconfig/emacs-fontconfig.conf".source = ./emacs-fontconfig.conf;

    "doom/init.el" = {
      source = ./doom/init.el;
    };

    "doom/config.el" = {
      source = ./doom/config.el;
    };

    "doom/packages.el" = {
      source = ./doom/packages.el;
    };
  };

  home.activation.doomSyncNotice =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -x "$HOME/.config/emacs/bin/doom" ]; then
        echo "Doom configuration changed; run: doom sync"
      fi
    '';
}
