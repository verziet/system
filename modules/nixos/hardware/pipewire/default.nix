{
  lib,
  config,
  ...
}: let
  moduleName = "pipewire";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    services.pipewire = {
      enable = lib.mkForce true;

      alsa.enable = lib.mkDefault true;
      alsa.support32Bit = lib.mkDefault true;
      pulse.enable = lib.mkDefault true;
    };

    security.rtkit.enable = lib.mkDefault true;
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = false;
    type = lib.types.bool;
  };
}
