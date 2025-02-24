{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    musnix = { url = "github:musnix/musnix"; };
  };
  outputs =
    { self
    , nixpkgs
    , home-manager
    , catppuccin
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        jupiter = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./nixos/configuration.nix
            catppuccin.nixosModules.catppuccin
            inputs.musnix.nixosModules.musnix
          ];
        };
      };
      homeConfigurations = {
        "lewis@jupiter" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };
    };
}
