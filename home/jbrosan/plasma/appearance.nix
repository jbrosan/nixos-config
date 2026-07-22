{ pkgs, ... }:

let
  blackPurpleGlassTheme = pkgs.runCommand "black-purple-glass-plasma-theme" {
    nativeBuildInputs = [
      pkgs.gzip
      pkgs.jq
      pkgs.python3
    ];
  } ''
    set -eu

    theme="$out/share/plasma/desktoptheme/BlackPurpleGlass"
    sourceTheme="${pkgs.kdePackages.libplasma}/share/plasma/desktoptheme/default"

    mkdir -p "$(dirname "$theme")"
    cp -R "$sourceTheme" "$theme"
    chmod -R u+w "$theme"

    jq '
      .KPlugin.Id = "BlackPurpleGlass"
      | .KPlugin.Name = "Black Purple Glass"
      | .KPlugin.Description = "Black and purple translucent Plasma style derived from Breeze"
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
contrast=1.0
saturation=1.35

[AdaptiveTransparency]
enabled=false
EOF

    patch_svg() {
      asset="$1"
      mode="$2"
      temporary="$asset.uncompressed"

      gzip -cd "$asset" > "$temporary"

      python3 -c '
import pathlib
import re
import sys

path = pathlib.Path(sys.argv[1])
mode = sys.argv[2]
text = path.read_text()

if mode == "panel-dialog":
    text, edge_count = re.subn(r"opacity:0\.5(?=[;\"])", "opacity:0.30", text)
    text, surface_count = re.subn(r"opacity:0\.85(?=[;\"])", "opacity:0.58", text)
    if edge_count == 0 or surface_count == 0:
        raise SystemExit("Expected panel/dialog opacity patterns were not found.")
elif mode == "widget":
    text, blurred_count = re.subn(r"opacity:0\.8(?=[;\"])", "opacity:0.58", text)
    text, normal_count = re.subn(
        r"opacity:1(?=;fill:currentColor)",
        "opacity:0.58",
        text,
    )
    if blurred_count == 0 or normal_count == 0:
        raise SystemExit("Expected widget opacity patterns were not found.")
else:
    raise SystemExit(f"Unknown patch mode: {mode}")

path.write_text(text)
' "$temporary" "$mode"

      gzip -9 -c "$temporary" > "$asset"
      rm "$temporary"
    }

    patch_svg "$theme/translucent/widgets/panel-background.svgz" panel-dialog
    patch_svg "$theme/translucent/dialogs/background.svgz" panel-dialog
    patch_svg "$theme/translucent/widgets/background.svgz" widget

    find "$theme" -type f -exec chmod 0444 {} +
  '';
in
{
  xdg.dataFile."color-schemes/BlackPurple.colors".source =
    ./assets/color-schemes/BlackPurple.colors;

  xdg.dataFile."plasma/desktoptheme/BlackPurpleGlass".source =
    "${blackPurpleGlassTheme}/share/plasma/desktoptheme/BlackPurpleGlass";

  programs.plasma.workspace = {
    lookAndFeel = "org.kde.breezedark.desktop";
    theme = "BlackPurpleGlass";
    colorScheme = "BlackPurple";
    wallpaper = "${./assets/black-purple-gradient.svg}";
  };
}
