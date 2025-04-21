{ pkgs, config, ... }:

let custom-pkgs = import ../pkgs { inherit pkgs; };
in {
  imports = [ ./shell ./applications ./scripts ./secrets.nix ];

  catppuccin.accent = "lavender";

  nix = {
    package = pkgs.nix;
    settings = { experimental-features = [ "flakes" "nix-command" ]; };
  };

  home.username = "felix";
  home.homeDirectory = "/home/felix";

  home.packages = [ custom-pkgs.banana-cursor ];

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

  home.sessionPath = [
    "${config.home.homeDirectory}/go/bin"
    "${config.home.homeDirectory}/.cargo/bin"
  ];

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
