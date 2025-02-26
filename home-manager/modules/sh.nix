{ pkgs
, config
, ...
}: {
  home.shell = {
    enableShellIntegration = true;
  };

  home.file = {
    ".p10k.zsh" = {
      source = ./lib/p10k.zsh;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      eval "$(direnv hook zsh)"
    '';

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "system-update";
    };

    history.save = 10000;

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "${config.home.homeDirectory}/.zsh_history";
    history.ignorePatterns = [ "rm *" "pkill *" "cp *" ];
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.1";
          sha256 = "sha256-vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
        };
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
}
