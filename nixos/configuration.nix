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
      description = "Lewis Flude";
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = [ "wheel" "networkmanager" "docker" "audio" ];
    };
  };

  system.stateVersion = "24.05";
}
