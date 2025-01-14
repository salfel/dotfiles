{ config, ... }: {
  sops = {
    defaultSopsFile = ../secrets/secrets.json;
    age.keyFile = "/home/felix/.config/sops/age/keys.txt";

    secrets = {
      "github_token" = {
        path = "/home/felix/.ssh/github_token";
        mode = "0600";
        sopsFile = ../secrets/ssh.json;
      };
      "github_token.pub" = {
        path = "/home/felix/.ssh/github_token.pub";
        mode = "0640";
        sopsFile = ../secrets/ssh.json;
      };

      "signing_key" = {
        path = "/home/felix/.ssh/signing_key";
        mode = "0600";
        sopsFile = ../secrets/signing.json;
      };
      "signing_key.pub" = {
        path = "/home/felix/.ssh/signing_key.pub";
        mode = "0640";
        sopsFile = ../secrets/signing.json;
      };
    };

    templates = {
      allowed_signers.content = ''
        * ${config.sops.placeholder."signing_key.pub"}
      '';
    };
  };
}
