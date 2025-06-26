{config, ...}: {
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = {
      "github_token" = {
        path = "${config.home.homeDirectory}/.ssh/github_token";
        mode = "0600";
        sopsFile = ../../../secrets/ssh.json;
      };
      "github_token.pub" = {
        path = "${config.home.homeDirectory}/.ssh/github_token.pub";
        mode = "0640";
        sopsFile = ../../../secrets/ssh.json;
      };

      "signing_key" = {
        path = "${config.home.homeDirectory}/.ssh/signing_key";
        mode = "0600";
        sopsFile = ../../../secrets/signing.json;
      };
      "signing_key.pub" = {
        path = "${config.home.homeDirectory}/.ssh/signing_key.pub";
        mode = "0640";
        sopsFile = ../../../secrets/signing.json;
      };

      "openai_secret_key" = {
        path = "${config.home.homeDirectory}/.opeanai";
        mode = "0640";
        sopsFile = ../../../secrets/openai.json;
      };
    };

    templates = {
      allowed_signers.content = ''
        * ${config.sops.placeholder."signing_key.pub"}
      '';

      openai_secret_key.content = ''
        ${config.sops.placeholder."openai_secret_key"}
      '';
    };
  };
}
