{config, ...}: {
  programs.git = {
    enable = true;

    userEmail = "dev.felix.salcher@gmail.com";
    userName = "Felix Salcher";

    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = config.sops.templates.allowed_signers.path;
      user.signingKey = "${config.home.homeDirectory}/.ssh/signing_key";
    };
  };
}
