{ pkgs, config, ... }:

let
  custom-pkgs = import ../pkgs { inherit pkgs; };
  sessionizer-script = pkgs.writeScriptBin "sessionizer"
    (builtins.readFile ./scripts/sessionizer.sh);
in {
  imports = [ ./shell ];

  nix = {
    package = pkgs.nix;
    settings = { experimental-features = [ "flakes" "nix-command" ]; };
  };

  home.username = "felix";
  home.homeDirectory = "/home/felix";

  home.packages = [ custom-pkgs.banana-cursor sessionizer-script ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = custom-pkgs.banana-cursor;
    size = 64;
    name = "Banana-Catppuccin-Mocha";
  };

  home.sessionVariables = { EDITOR = "nvim"; };

  home.sessionPath = [ "${config.home.homeDirectory}/go/bin" ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
