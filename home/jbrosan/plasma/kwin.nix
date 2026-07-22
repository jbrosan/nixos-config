{ ... }:

{
  programs.plasma.configFile.kwinrc = {
    Plugins = {
      blurEnabled = true;
      contrastEnabled = true;
      translucencyEnabled = true;
    };
  };
}
