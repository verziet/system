{
  lib,
  config,
  ...
}: let
  moduleName = "gnome";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    services = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
