{ config, lib, pkgs, ... }:

{

  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "theKitchen"; 

  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

  users.users.ajv = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  

  programs.niri.enable = true;
  programs.noctalia.enable =  true;

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    neovim 
    alacritty
  ];
  
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [];

  system.stateVersion = "26.05"; # Don't Change

}

