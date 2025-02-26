{ pkgs, ... }: {
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "zfs";
    };

    # virtualbox = {
    #   host.enable = true;
    #   host.enableExtensionPack = true;
    #   guest.enable = true;
    #   guest.dragAndDrop = true;
    # };

    # libvirtd = {
    #   enable = true;
    #   qemu = {
    #     package = pkgs.qemu_kvm;
    #     ovmf.enable = true;
    #     swtpm.enable = true;
    #     runAsRoot = true;
    #   };
    # };
  };

  # boot.kernelModules = [ "kvm-intel" "kvm-amd" ];

  # boot.extraModprobeConfig = ''
  #   options kvm_intel nested=1
  #   options kvm_amd nested=1
  # '';

  # users.users.lewis.extraGroups = [ "libvirtd" "kvm" "qemu-libvirtd" ];

  # services.spice-vdagentd.enable = true;

  # environment.systemPackages = with pkgs; [
  #   virt-manager
  #   virt-viewer
  #   spice
  #   spice-gtk
  #   spice-protocol
  #   win-virtio
  #   OVMF
  #   qemu-utils
  # ];
}
