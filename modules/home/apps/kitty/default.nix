{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.wyrdgard;
let
  cfg = config.wyrdgard.apps.kitty;
in
{
  options.wyrdgard.apps.kitty = {
    enable = mkEnableOption "Kity";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ kitty ];

    programs.kitty = {
      enable = true;
      theme = "Tokyo Night";
      font = {
        name = "Code New Roman";
        size = 15;
      };
      shellIntegration.enableFishIntegration = true;
      settings = {
        "background_opacity" = "0.95";
        "shell" = "fish";
      };
    };
  };
}
