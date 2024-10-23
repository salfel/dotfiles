{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, nixos-hardware, ... }@inputs: 
  let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ 
          ./system/configuration.nix
          nixos-hardware.nixosModules.framework-13-7040-amd
        ];
        specialArgs = { inherit inputs; inherit system; };
      };
    };
    homeConfigurations = {
      felix = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./user/home.nix
          catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };
}
