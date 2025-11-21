{
  virtualisation = {
    docker.enable = true;

    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };

    spiceUSBRedirection.enable = true;
  };

  users.users.felix.extraGroups = ["kvm" "docker" "vboxusers"];
}
