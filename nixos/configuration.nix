{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/default.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };


  users.defaultUserShell = pkgs.zsh;

  users.users = {
    lewis = {
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Lewis Flude";
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    };
  };

  system.stateVersion = "24.05";
}
