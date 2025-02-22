{pkgs, ...}: {
  home.sessionVariables = {
    EDITOR = "hx";
    SUDO_EDITOR = "hx";
  };

  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          scope = "source.nix";
          injection-regex = "nix";
          file-types = ["nix"];
          comment-token = "#";
          language-servers = ["nil"];
          indent = {
            tab-width = 2;
            unit = "  ";
          };
          formatter = {
            command = "nixpkgs-fmt";
          };
          auto-format = true;
        }
      ];
    };
  };
  vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      kamadorueda.alejandra
      (pkgs.catppuccin-vsc.override {
        accent = "mauve";
        boldKeywords = true;
        italicComments = true;
        italicKeywords = true;
        extraBordersEnabled = false;
        workbenchMode = "default";
        bracketMode = "rainbow";
        colorOverrides = {};
        customUIColors = {};
      })
    ];
    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "catppuccin.accentColor" = "mauve";
      "catppuccin.boldKeywords" = true;
      "catppuccin.italicComments" = true;
      "catppuccin.italicKeywords" = true;
      "catppuccin.workbenchMode" = "default";
      "catppuccin.bracketMode" = "rainbow";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.formatterPath" = "nixpkgs-fmt";
    };
  };
}
