{lib, config, pkgs, ... }:

{
  options = {
    main-user.enable = lib.mkEnableOption "enable user module";

    main-user.username = lib.mkOption {
      default = "mainuser";
      description = ''username'';
    }
  };

  config = lib.mkIf config.main-user.enable {
  users.users.${config.main-user.userName} = {
    isNormalUser = true;
    initialPassword = "asdf";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };
  };

}
