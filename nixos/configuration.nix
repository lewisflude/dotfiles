{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/cache.nix
    ./modules/theme.nix
    ./modules/desktop-environment.nix
    ./modules/gaming.nix
    ./modules/graphics.nix
    ./modules/media.nix
    ./modules/boot.nix
    ./modules/terminal.nix
    ./modules/file-management.nix
    ./modules/networking.nix
    ./modules/virtualisation.nix
    ./modules/window-management.nix
    ./modules/version-control.nix
    ./modules/sh.nix
    ./modules/ssh.nix
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
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    };
  };

  system.stateVersion = "24.05";
}
