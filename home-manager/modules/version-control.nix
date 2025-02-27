{ ... }: {
  programs.git = {
    enable = true;
    userEmail = "lewis@lewisflude.com";
    signing.key = "0x221F0B8B8FFF5BD3";
    extraConfig.commit.gpgsign = true;
  };
}
