{ pkgs, lib, config, ... }:

let
  homeDirectory = config.users.users.lewis.home;
  yubikey-up =
    let
      yubikeyIds = lib.concatStringsSep " " (
        lib.mapAttrsToList (name: id: "[${name}]=\"${builtins.toString id}\"") config.yubikey.identifiers
      );
    in
    pkgs.writeShellApplication {
      name = "yubikey-up";
      runtimeInputs = builtins.attrValues { inherit (pkgs) gawk yubikey-manager; };
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        serial=$(ykman list | awk '{print $NF}')
        # If it got unplugged before we ran, just don't bother
        if [ -z "$serial" ]; then
          exit 0
        fi

        declare -A serials=(${yubikeyIds})

        key_name=""
        for key in "''${!serials[@]}"; do
          if [[ $serial == "''${serials[$key]}" ]]; then
            key_name="$key"
          fi
        done

        if [ -z "$key_name" ]; then
          echo WARNING: Unidentified yubikey with serial "$serial" . Won\'t link an SSH key.
          exit 0
        fi

        echo "Creating links to ${homeDirectory}/id_$key_name"
        ln -sf "${homeDirectory}/.ssh/id_$key_name" ${homeDirectory}/.ssh/id_yubikey
        ln -sf "${homeDirectory}/.ssh/id_$key_name.pub" ${homeDirectory}/.ssh/id_yubikey.pub
      '';
    };
  yubikey-down = pkgs.writeShellApplication {
    name = "yubikey-down";
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      rm ${homeDirectory}/.ssh/id_yubikey
      rm ${homeDirectory}/.ssh/id_yubikey.pub
    '';
  };
in

{

  options = {
    yubikey = {
      enable = lib.mkEnableOption "Enable yubikey support";
      identifiers = lib.mkOption {
        default = { };
        type = lib.types.attrsOf lib.types.int;
        description = "Attrset of Yubikey serial numbers";
        example = lib.literalExample ''
          {
            foo = 12345678;
            bar = 87654321;
          }
        '';
      };
    };
  };
  config = {

    yubikey = {
      enable = true;
      identifiers = {
        yubi = 30043632;
      };
    };

    environment.systemPackages = with pkgs; [
      yubioath-flutter
      pinentry-curses
      pam_u2f
      yubikey-up
      yubikey-down
    ];


    services = {

      # Create ssh files
      # Yubikey 4/5 U2F+CCID
      # SUBSYSTEM == "usb", ATTR{idVendor}=="1050", ENV{ID_SECURITY_TOKEN}="1", GROUP="wheel"
      # We already have a yubikey rule that sets the ENV variable

      # This is linux only
      udev.extraRules = ''
        # Link/unlink ssh key on yubikey add/remove
        SUBSYSTEM=="usb", ACTION=="add", ATTR{idVendor}=="1050", RUN+="${lib.getBin yubikey-up}/bin/yubikey-up"
        # NOTE: Yubikey 4 has a ID_VENDOR_ID on remove, but not Yubikey 5 BIO, whereas both have a HID_NAME.
        # Yubikey 5 HID_NAME uses "YubiKey" whereas Yubikey 4 uses "Yubikey", so matching on "Yubi" works for both
        SUBSYSTEM=="hid", ACTION=="remove", ENV{HID_NAME}=="Yubico Yubi*", RUN+="${lib.getBin yubikey-down}/bin/yubikey-down"

        SUBSYSTEM=="hid",\
         ACTION=="remove",\
         ENV{HID_NAME}=="Yubico YubiKey OTP+FIDO+CCID",\
         RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"

        SUBSYSTEM=="hid",\
         ACTION=="add",\
         ENV{HID_NAME}=="Yubico YubiKey OTP+FIDO+CCID",\
         RUN+="${pkgs.systemd}/bin/loginctl activate 1";\
         RUN+="${lib.getBin pkgs.xorg.xset}/bin/xset dpms force on"
      '';

      pcscd.enable = true;
      udev.packages = [ pkgs.yubikey-personalization ];
      yubikey-agent.enable = true;
    };

    security.sudo.extraConfig = ''
      Defaults        timestamp_timeout=30
    '';

    security.pam = {
      u2f = {
        enable = true;
        settings = {
          cue = true;
          debug = false;
          authFile = "/home/lewis/.config/Yubico/u2f_keys";
          origin = "pam://jupiter";
        };
      };
      yubico = {
        enable = true;
        debug = false;
        mode = "challenge-response";
        id = [ "30043632" ];
      };
      sshAgentAuth.enable = true;
      services = {
        login = {
          u2fAuth = true;
          enableGnomeKeyring = true;
        };
        sudo = {
          u2fAuth = true;
          sshAgentAuth = true;
          enableGnomeKeyring = true;
        };
        greetd = {
          u2fAuth = true;
          enableGnomeKeyring = true;
        };

        hyprlock = {
          u2fAuth = true;
        };

        sshd = {
          u2fAuth = true;
        };

        polkit-1 = {
          u2fAuth = true;
        };
      };
    };
  };
}
