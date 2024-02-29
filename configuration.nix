{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./programs/nixvim.nix
    inputs.pre-commit-hooks-nix.flakeModule
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  
  # Enable networking
  networking.networkmanager.enable = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

# Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  programs.zsh = {
    enable = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    #essentials
    git
    neovim
    kitty
    zsh
    zsh-powerlevel10k
    bash
    wget

    # nice to have
    neofetch
    fd
    tree
    ripgrep
    clang

    # make sure our nix files always look good
    alejandra
    pre-commit
    
    # mostly for pactl
    pulseaudio
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  perSystem.pre-commit = {
    check.enable = true;
    settings.settings.alejandra.check = true;
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
