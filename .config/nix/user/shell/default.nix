{ configs, pkgs, ... }: 
{
  imports = [
    ./zsh.nix
    ./starship.nix
    ./tmux.nix
  ];
}
