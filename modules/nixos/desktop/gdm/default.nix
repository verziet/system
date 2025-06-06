{
  lib,
  config,
  ...
}: let
  moduleName = "gdm";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    services.displayManager = {
      gdm.enable = lib.mkForce true;
      defaultSession = lib.mkIf config."hyprland".enableModule (lib.mkDefault "hyprland-uwsm");
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
