{ ... }:

{
  xdg.configFile = {
    "niri/config.kdl".source = ./config.kdl;
    "niri/input.kdl".source = ./input.kdl;
    "niri/layout.kdl".source = ./layout.kdl;
    "niri/startup.kdl".source = ./startup.kdl;
    "niri/binds.kdl".source = ./binds.kdl;
    "niri/window-rules.kdl".source = ./window-rules.kdl;

    "niri/outputs/framework-13.kdl".source = ./outputs/framework-13.kdl;
    "niri/outputs/framework-13-pro.kdl".source = ./outputs/framework-13-pro.kdl;
    "niri/outputs/desktop.kdl".source = ./outputs/desktop.kdl;
  };
}
