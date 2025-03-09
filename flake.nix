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
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    protontweaks = {
      url = "github:rain-cafe/protontweaks/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix = { url = "github:musnix/musnix"; };
  };
  outputs =
    { self
    , nixpkgs
    , home-manager
    , catppuccin
    , hyprpanel
    , protontweaks
    , musnix
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
            musnix.nixosModules.musnix
            ({ pkgs, ... }: {
              imports = [
                protontweaks.nixosModules.protontweaks
              ];

              nixpkgs = {
                overlays = [
                  inputs.protontweaks.overlay
                ];
              };
            })
          ];
        };
      };
      homeConfigurations = {
        "lewis@jupiter" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              hyprpanel.overlay
              (final: prev: {
                ghostty = inputs.ghostty.packages.${system}.default;
              })
              protontweaks.overlay
            ];
          };
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/home.nix
            catppuccin.homeManagerModules.catppuccin
            hyprpanel.homeManagerModules.hyprpanel
          ];
        };
      };
    };
}
