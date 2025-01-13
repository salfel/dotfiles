{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.keyFile = "/home/felix/.config/sops/age/keys.txt";

    secrets = {
      "ssh/id_ed25519" = {
        path = "/home/felix/.ssh/id_ed25519";
        mode = "0600";
      };
    };
  };
}
