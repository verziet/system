{
  lib,
  config,
  ...
}: let
  moduleName = "nvidia";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    services.xserver.videoDrivers = ["nvidia"];

    hardware = {
      graphics = {
        enable = lib.mkForce true;
        enable32Bit = lib.mkForce true;
      };

      nvidia = {
        prime = {
          offload = {
            enable = lib.mkOverride 999 true;
            enableOffloadCmd = lib.mkDefault true;
          };

          intelBusId = lib.mkDefault "PCI:0:2:0";
          nvidiaBusId = lib.mkDefault "PCI:1:0:0";
        };

        # Modesetting is required.
        modesetting.enable = lib.mkForce true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
        # of just the bare essentials.
        powerManagement.enable = lib.mkDefault false;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = lib.mkDefault true;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of
        # supported GPUs is at:
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
        # Only available from driver 515.43.04+
        open = lib.mkDefault true;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = lib.mkDefault false;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.latest;
      };
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
