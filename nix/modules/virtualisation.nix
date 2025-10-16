{pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;

  users.users.felix.extraGroups = ["libvirtd" "kvm"];
}
