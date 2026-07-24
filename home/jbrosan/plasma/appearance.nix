{ pkgs, ... }:

let
  mkGlassTheme =
    {
      derivationName,
      themeId,
      themeName,
      description,
      contrast ? 1.0,
      saturation ? 1.0,
      panelOpacity ? "0.58",
      dialogOpacity ? "0.58",
      backgroundOpacity ? "0.58",
      secondaryOpacity ? "0.30",
    }:
    pkgs.runCommand derivationName
      {
        nativeBuildInputs = [
          pkgs.gzip
          pkgs.jq
        ];
      }
      ''
              set -eu

              theme="$out/share/plasma/desktoptheme/${themeId}"
              sourceTheme="${pkgs.kdePackages.libplasma}/share/plasma/desktoptheme/default"

              mkdir -p "$(dirname "$theme")"
              cp -R "$sourceTheme" "$theme"
              chmod -R u+w "$theme"

              jq '
                .KPlugin.Id = "${themeId}"
                | .KPlugin.Name = "${themeName}"
                | .KPlugin.Description = "${description}"
              ' "$theme/metadata.json" > "$theme/metadata.json.new"

              mv "$theme/metadata.json.new" "$theme/metadata.json"

              cat > "$theme/plasmarc" <<EOF
        [Wallpaper]
        defaultWallpaperTheme=Next
        defaultFileSuffix=.png
        defaultWidth=1920
        defaultHeight=1080

        [ContrastEffect]
        enabled=true
        contrast=${toString contrast}
        saturation=${toString saturation}

        [AdaptiveTransparency]
        enabled=false
        EOF

              patch_asset() {
                asset="$1"
                primaryOpacity="$2"
                secondary="$3"
                temporary="$asset.uncompressed"

                gzip -cd "$asset" > "$temporary"

                substituteInPlace "$temporary" \
                  --replace-quiet "opacity:0.85" "opacity:$primaryOpacity" \
                  --replace-quiet "opacity:0.8" "opacity:$primaryOpacity" \
                  --replace-quiet "opacity:0.5" "opacity:$secondary"

                gzip -9 -c "$temporary" > "$asset"
                rm "$temporary"
              }

              patch_asset "$theme/translucent/widgets/panel-background.svgz" "${panelOpacity}" "${secondaryOpacity}"
              patch_asset "$theme/translucent/dialogs/background.svgz" "${dialogOpacity}" "${secondaryOpacity}"
              patch_asset "$theme/translucent/widgets/background.svgz" "${backgroundOpacity}" "${secondaryOpacity}"

              find "$theme" -type f -exec chmod 0444 {} +
      '';

  blackPurpleGlassTheme = mkGlassTheme {
    derivationName = "black-purple-glass-plasma-theme";
    themeId = "BlackPurpleGlass";
    themeName = "Black Purple Glass";
    description = "Black and purple translucent Plasma style derived from Breeze";
    saturation = 1.35;
    panelOpacity = "0.58";
    dialogOpacity = "0.58";
    backgroundOpacity = "0.58";
    secondaryOpacity = "0.30";
  };

  vaderGlassTheme = mkGlassTheme {
    derivationName = "vader-glass-plasma-theme";
    themeId = "VaderGlass";
    themeName = "Vader Glass";
    description = "OLED black, graphite, smoked glass, and restrained Imperial red Plasma style";
    saturation = 0.92;
    panelOpacity = "0.50";
    dialogOpacity = "0.54";
    backgroundOpacity = "0.52";
    secondaryOpacity = "0.24";
  };
in
{
  xdg.dataFile."color-schemes/BlackPurple.colors".source = ./assets/color-schemes/BlackPurple.colors;

  xdg.dataFile."plasma/desktoptheme/BlackPurpleGlass".source =
    "${blackPurpleGlassTheme}/share/plasma/desktoptheme/BlackPurpleGlass";

  xdg.dataFile."color-schemes/Vader.colors".source = ./assets/color-schemes/Vader.colors;

  xdg.dataFile."plasma/desktoptheme/VaderGlass".source =
    "${vaderGlassTheme}/share/plasma/desktoptheme/VaderGlass";

  programs.plasma.workspace = {
    lookAndFeel = "org.kde.breezedark.desktop";
    theme = "VaderGlass";
    colorScheme = "Vader";
    wallpaper = "${./assets/vader-glass.svg}";
  };
}
