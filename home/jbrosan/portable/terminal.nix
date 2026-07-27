{ ... }:

{
  # Ghostty itself stays host-managed for native GTK/Wayland integration.
  xdg.configFile."ghostty/config".source = ../ghostty/config;
  xdg.configFile."ghostty/shaders/cursor_frozen.glsl".source = ../ghostty/shaders/cursor_frozen.glsl;
  xdg.configFile."ghostty/shaders/trail.glsl".source = ../ghostty/shaders/trail.glsl;
  xdg.configFile."ghostty/themes/dankcolors".source = ../ghostty/themes/dankcolors;
}
