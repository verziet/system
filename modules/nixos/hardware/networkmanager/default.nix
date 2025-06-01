{
  lib,
  config,
  ...
}: let
  moduleName = "networkmanager";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    networking.networkmanager.enable = lib.mkForce true;
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
