{ pkgs, config, ... }: {
  home.packages = with pkgs; [ git gh git-credential-manager ];

  programs.git = {
    enable = true;

    userEmail = "dev.felix.salcher@gmail.com";
    userName = "Felix Salcher";

    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = config.sops.templates.allowed_signers.path;
      user.signingKey = "/home/felix/.ssh/signing_key";

      push.autoSetupRemote = true;
    };
  };
}
