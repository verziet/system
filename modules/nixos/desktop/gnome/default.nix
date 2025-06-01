{
  lib,
  config,
  ...
}: let
  moduleName = "gnome";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
