{ config, lib, pkgs, ... }:

{
  networking.hostName = "theKitchen"; 

  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/default.nix
    ];

  hardware.bluetooth.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.thermald.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "America/Toronto";
  
  environment.sessionVariables = {
    XCURSOR_SIZE = 8;
  };

  system.stateVersion = "26.05"; # Don't Change

}

