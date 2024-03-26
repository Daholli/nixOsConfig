{ options, config, lib, pkgs, ... }:

with lib;
with lib.wyrdgard;
let
  cfg = config.wyrdgard.system.hardware.bluetooth;
in
{
  options.wyrdgard.system.hardware.bluetooth = with types; {
    enable = mkBoolOpt false "Whether or not to enable bluetooth";
  };

  config = mkIf cfg.enable {

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
