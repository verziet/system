{
  lib,
  config,
  ...
}: let
  moduleName = "gnome";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    services = {
      xserver.desktopManager.gnome.enable = lib.mkForce true;
      gnome.core-utilities.enable = lib.mkOverride 999 false;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
