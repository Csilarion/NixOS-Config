{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/users/${config.home.username}/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    niri = "niri";
    alacritty = "alacritty";
  };
in

{
  home.username = "ajv";
  home.homeDirectory = "/home/ajv";
  home.stateVersion = "26.05";

  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    package = pkgs.git.override { withLibsecret=true; };
    settings = {
      credential.helper = "libsecret";
      user = {
        email = "aidan.voigt@gmail.com";
	name = "Aidan Voigt";
      };
    };
  };

#Junk Commetn

  # programs.noctalia = {
  #   settings = {
  #     mode = "dark";
  #     source = "builtin";
  #     wallpaper_scheme = "m3-content";
  #   };
  # };

  xdg.configFile = builtins.mapAttrs 
  (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) 
  configs;
}
