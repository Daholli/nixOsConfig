# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  callPackage,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../configuration.nix
    inputs.nixvim.nixosModules.nixvim
    ./../../programs/default.nix
  ];

  # Define your hostname.
  networking.hostName = "yggdrasil";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  fileSystems."/var/lib/bluetooth" = {
    device = "/persist/var/lib/bluetooth";
    options = ["bind" "noauto" "x-systemd.automount"];
    noCheck = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # nvidia
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  environment.pathsToLink = ["/libexec"];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];

    #   # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    #   # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cholli = {
    isNormalUser = true;
    home = "/home/cholli";
    extraGroups = ["wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      discord
      vivaldi
      vivaldi-ffmpeg-codecs
      steam
      noisetorch
      prismlauncher
    ];
  };

  # Set shell as well
  users.users.cholli.shell = pkgs.zsh;
  environment.shells = with pkgs; [zsh fish];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "cholli" = import ./home.nix;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    rustup
    eww
    hyprpaper
    hyprlock
    dunst
    libnotify
    rofi-wayland
    fish
    starship
    lxqt.lxqt-policykit
  ];

  # Enable the unfree 1Password packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "1password-gui"
      "1password"
    ];

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["CodeNewRoman" "NerdFontsSymbolsOnly"];})
      font-awesome
      powerline-fonts
      powerline-symbols
    ];
  };

  ## Program configurations
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red) ";
        vicmd_symbol = "[](bold blue) ";
      };
    };
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      starship init fish | source
    '';
  };

  programs.noisetorch.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = ["cholli"];
  };

  environment.variables.EDITOR = "nvim";
  environment.variables.SUDOEDITOR = "nvim";

  system.stateVersion = "23.11";
}
