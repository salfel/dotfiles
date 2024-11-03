{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";
      
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprpanel.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... }@inputs: 
  let 
      system = "x86_64-linux";

      machines = [ "framework" ];

      mkMachine = name:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./machines/${name}/hardware-configuration.nix
            ./configuration.nix
          ];
          specialArgs = { inherit inputs; inherit system; };
        };
  in {
    nixosConfigurations = builtins.listToAttrs (map (name: { inherit name; value = mkMachine name; }) machines);
    homeConfigurations = {
      felix = home-manager.lib.homeManagerConfiguration {
        modules = [ 
          ./home/home.nix
          catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };
}
