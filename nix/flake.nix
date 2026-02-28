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

    sessionizer.url = "github:salfel/sessionizer/master";
    sessionizer.inputs.nixpkgs.follows = "nixpkgs";

    helium.url = "github:AlvaroParker/helium-nix";
    helium.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    nixpkgs,
    home-manager,
    catppuccin,
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
          ./machines/${name}

          ./configuration.nix

          home-manager.nixosModules.home-manager
          catppuccin.nixosModules.catppuccin

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit customPkgs;
                inherit inputs;
              };
              users.felix = {
                imports = [
                  ./home/home.nix
                  catppuccin.homeModules.catppuccin
                  sops-nix.homeManagerModules.sops
                ];
              };
            };
          }
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
  };
}
