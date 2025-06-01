{
  lib,
  config,
  ...
}: let
  moduleName = "clamav";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    services.clamav = {
      daemon.enable = lib.mkForce true;

      updater.enable = lib.mkDefault true;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
