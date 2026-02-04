{
  virtualisation = {
    docker.enable = true;
  };

  users.users.felix.extraGroups = ["kvm" "docker"];
}
