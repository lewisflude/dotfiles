{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    yubioath-flutter
    yubikey-manager
    pinentry-curses
    pam_u2f
  ];

  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.yubikey-agent.enable = true;

  security.pam = {
    u2f = {
      enable = true;
      settings = {
        cue = true;
        debug = true;
        authFile = "/home/lewis/.config/Yubico/u2f_keys";
        origin = "pam://jupiter";
      };
    };
    sshAgentAuth.enable = true;
    services = {
      login.u2fAuth = true;
      sudo = {
        u2fAuth = true;
        sshAgentAuth = true;
      };
    };
  };
}
