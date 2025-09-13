{
  description = "My personal dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    sessionizer.url = "github:salfel/sessionizer/master";
    sessionizer.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    nixpkgs,
    home-manager,
    catppuccin,
    disko,
    sops-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    machines = ["framework"];

    customPkgs = import ./pkgs {inherit pkgs;};

    mkMachine = name:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          disko.nixosModules.disko
          ./machines/${name}/disko-config.nix
          ./machines/${name}/hardware-configuration.nix

          ./configuration.nix
        ];
        specialArgs = {
          inherit inputs;
          inherit system;
          inherit customPkgs;
        };
      };
  in {
    nixosConfigurations = builtins.listToAttrs (map (name: {
        inherit name;
        value = mkMachine name;
      })
      machines);
    homeConfigurations.felix = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home
        catppuccin.homeModules.catppuccin
        sops-nix.homeManagerModules.sops
      ];

      extraSpecialArgs = {
        inherit customPkgs;
        inherit inputs;
      };
    };
  };
}
