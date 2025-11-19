{pkgs, ...}: {
  virtualisation = {
    docker.enable = true;

    libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };

    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;

  users.users.felix.extraGroups = ["libvirtd" "kvm" "docker" "vboxusers"];
}
