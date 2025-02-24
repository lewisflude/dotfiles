{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    (writeShellScriptBin "system-update" ''
      #!/bin/sh
      set -e # Exit on error

      FLAKE_PATH="${config.home.homeDirectory}/.dotfiles"
      
      echo "🔄 Updating flake inputs..."
      nix flake update --flake "$FLAKE_PATH"
      
      echo "⚙️ Building new system configuration..."
      sudo nixos-rebuild switch --flake "$FLAKE_PATH"#jupiter
      
      echo "🏠 Updating home-manager configuration..."
      home-manager switch --flake "$FLAKE_PATH"#lewis@jupiter
      
      echo "🧹 Running garbage collection..."
      nix-collect-garbage -d
      
      echo "✨ System update complete!"
      
      # Print current system and home-manager generations
      echo "Current system generation:"
      sudo nix-env -p /nix/var/nix/profiles/system --list-generations | tail -n 1
      
      echo "Current home-manager generation:"
      home-manager generations | head -n 1
    '')
    (writeShellScriptBin "link-pipewire-nodes" ''
      #!/usr/bin/env bash

      # ports obtained from `pw-link -io`

      pw-link "Main-Output-Proxy:monitor_FL" "alsa_output.usb-Apogee_Electronics_Corp_Symphony_Desktop-00.pro-output-0:playback_AUX0"
      pw-link "Main-Output-Proxy:monitor_FR" "alsa_output.usb-Apogee_Electronics_Corp_Symphony_Desktop-00.pro-output-0:playback_AUX1"

      pw-link "alsa_input.usb-Apogee_Electronics_Corp_Symphony_Desktop-00.pro-input-0:capture_AUX0" "Microphone-Proxy:input_MONO"

    '')
  ];
}
