{ options
, config
, pkgs
, lib
, ...
}:
with lib;
with lib.wyrdgard; let
  cfg = config.wyrdgard.system.locale;
in
{
  options.wyrdgard.system.locale = with types; {
    enable = mkBoolOpt false "Whether or not to manage locale settings.";
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_TIME = "de_DE.UTF-8";
    };

    console = {
      keyMap = mkForce "us";
    };
  };
}