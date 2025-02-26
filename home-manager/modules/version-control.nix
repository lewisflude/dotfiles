{ ... }: {
  programs.git = {
    enable = true;
    userEmail = "lewis@lewisflude.com";
    signing.key = "0x4EE1F251042A46F1";
    extraConfig.commit.gpgsign = true;
  };
}
