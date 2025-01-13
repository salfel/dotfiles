{
  sops = {
    defaultSopsFile = ../secrets/secrets.json;
    age.keyFile = "/home/felix/.config/sops/age/keys.txt";

    secrets = {
      "github_token" = {
        path = "/home/felix/.ssh/github_token";
        mode = "0600";
        owner = "felix";
        group = "users";
      };
      "github_token.pub" = {
        path = "/home/felix/.ssh/github_token.pub";
        mode = "0640";
        owner = "felix";
        group = "users";
      };
    };
  };
}
