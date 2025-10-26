{
  pkgs,
  config,
  ...
}: let
  ignorePath = "${config.home.homeDirectory}/.gitignore";
  ignoreFiles = ''
    .ccls-cache
  '';
in {
  home.file."${ignorePath}".text = ignoreFiles;
  home.packages = with pkgs; [git gh git-credential-manager];

  programs.git = {
    enable = true;

    settings = {
      core.excludesFile = ignorePath;
      push.autoSetupRemote = true;
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = config.sops.templates.allowed_signers.path;

      user = {
        email = "dev.felix.salcher@gmail.com";
        name = "Felix Salcher";
        signingKey = "${config.home.homeDirectory}/.ssh/signing_key";
      };
    };
  };
}
