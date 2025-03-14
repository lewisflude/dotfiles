{
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "524288";
    }
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "524288";
    }
  ];
  systemd.extraConfig = "DefaultLimitNOFILE=524288";
}
