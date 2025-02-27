{ config, lib, ... }:
let

  publicKey = "${config.home.homeDirectory}/.ssh/id_yubikey.pub";
  publicGitEmail = "lewis@lewisflude.com";
in
{
  programs.git =
    {
      enable = true;
      userEmail = "${publicGitEmail}";
      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signing.key = "${publicKey}";
        gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
      };
      signing = {
        signByDefault = true;
        key = publicKey;
      };
      ignores = [
        ".csvignore"
        ".direnv"
        "result"
      ];
    };

  # NOTE: To verify github.com update commit signatures, you need to manually import
  home.file.".ssh/allowed_signers".text = ''
    ${publicGitEmail} ${lib.fileContents ./lib/ssh-keys/id_yubi.pub}
  '';
}
