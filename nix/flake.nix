{
  description = "My personal dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    ghostty.url = "github:ghostty-org/ghostty";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { nixpkgs, home-manager, catppuccin, disko, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;

        overlays = [ (import ./overlays/easyeda2kicad.nix) ];
      };

      machines = [ "framework" ];

      mkMachine = name:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            catppuccin.nixosModules.catppuccin
            ./machines/${name}/disko-config.nix
            ./machines/${name}/hardware-configuration.nix

            ./configuration.nix
          ];
          specialArgs = {
            inherit inputs;
            inherit system;
          };
        };
    in {
      nixosConfigurations = builtins.listToAttrs (map (name: {
        inherit name;
        value = mkMachine name;
      }) machines);
      homeConfigurations = {
        felix = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules =
            [ ./home/home.nix catppuccin.homeManagerModules.catppuccin ];
        };
      };
    };
}
