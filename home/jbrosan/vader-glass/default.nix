{ ... }:

{
  home.file = {
    ".config/Kvantum/VaderGlassKvantum/VaderGlassKvantum.kvconfig" = {
      source = ./assets/kvantum/VaderGlassKvantum.kvconfig;
      force = true;
    };
    ".config/Kvantum/VaderGlassKvantum/VaderGlassKvantum.svg" = {
      source = ./assets/kvantum/VaderGlassKvantum.svg;
      force = true;
    };
    ".config/VaderGlass/dolphin-places.qss" = {
      source = ./assets/dolphin/dolphin-places.qss;
      force = true;
    };
    ".local/bin/dolphin-vader-glass" = {
      source = ./assets/dolphin/dolphin-vader-glass;
      executable = true;
      force = true;
    };
    ".local/share/applications/org.kde.dolphin.desktop" = {
      source = ./assets/dolphin/org.kde.dolphin.desktop;
      force = true;
    };
    ".local/share/color-schemes/VaderGlass.colors" = {
      source = ./assets/color-schemes/VaderGlass.colors;
      force = true;
    };
    ".local/share/plasma/desktoptheme/VaderGlass/metadata.json" = {
      source = ./assets/plasma/metadata.json;
      force = true;
    };
    ".local/share/plasma/desktoptheme/VaderGlass/dialogs/background.svgz" = {
      source = ./assets/plasma/dialogs/background.svgz;
      force = true;
    };
    ".local/share/plasma/desktoptheme/VaderGlass/widgets/background.svgz" = {
      source = ./assets/plasma/widgets/background.svgz;
      force = true;
    };
    ".local/share/plasma/desktoptheme/VaderGlass/widgets/tooltip.svgz" = {
      source = ./assets/plasma/widgets/tooltip.svgz;
      force = true;
    };
  };
}
