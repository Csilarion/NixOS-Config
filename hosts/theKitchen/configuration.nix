{ config, lib, pkgs, ... }:

{
  networking.hostName = "theKitchen"; 

  imports =
    [ 
      ./hardware-configuration.nix
    ];

  hardware.bluetooth.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.thermald.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

  users.users.ajv = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  

  programs.niri.enable = true;
  programs.xwayland.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "ajv";
      };
    };
  };
  systemd.user.services.niri.enableDefaultPath = false;

  programs.steam = {
    enable = true;
  };

  environment.sessionVariables = {
    # XCURSOR_THEME="Vanilla-DMZ";
    XCURSOR_SIZE = 8;
  };

  environment.systemPackages = with pkgs; [
    wget
    # git
    # neovim 
    alacritty
    xwayland-satellite
  ];
  
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
  ];

  system.stateVersion = "26.05"; # Don't Change

}

