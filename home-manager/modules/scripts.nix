{
  home.packages = with pkgs; [
    (writeShellScriptBin "system-update" ''
      #!/bin/sh
      set -e # Exit on error

      FLAKE_PATH="$HOME/.dotfiles#lewis@jupiter"
      
      echo "🔄 Updating flake inputs..."
      nix flake update "$HOME/.dotfiles"
      
      echo "⚙️ Building new system configuration..."
      sudo nixos-rebuild switch --flake "$FLAKE_PATH"
      
      echo "🏠 Updating home-manager configuration..."
      home-manager switch --flake "$FLAKE_PATH"
      
      echo "🧹 Running garbage collection..."
      nix-collect-garbage -d
      
      echo "✨ System update complete!"
      
      # Print current system and home-manager generations
      echo "\nCurrent system generation:"
      sudo nix-env -p /nix/var/nix/profiles/system --list-generations | tail -n 1
      
      echo "\nCurrent home-manager generation:"
      home-manager generations | head -n 1
    '')
  ];

  # Optional: Add shell aliases for even quicker access
  programs.bash.shellAliases = {
    update = "system-update";
  };

  # If you use Fish shell
  programs.fish.shellAliases = {
    update = "system-update";
  };

  # If you use Zsh
  programs.zsh.shellAliases = {
    update = "system-update";
  };
}
