{config, pkgs, ...}:

{
  
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;

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


  environment.systemPackages = with pkgs; [
    wget
    alacritty
    xwayland-satellite
  ];
  
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
  ];

}
