{ pkgs, ... }: {
  catppuccin = {
    flavor = "mocha";
    enable = true;
  };

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
}
