{ configs, pkgs, ... }: 
{
  imports = [
    ./zsh.nix
    ./starship.nix
    ./tmux.nix
    ./git.nix
    ./kitty.nix
    ./lazygit.nix
  ];
}
