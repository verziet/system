{
  lib,
  config,
  ...
}: let
  moduleName = "displaylink";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    services.xserver.videoDrivers = ["displaylink" "modesetting"];
    boot.extraModulePackages = with config.boot.kernelPackages; [evdi];
    boot.kernelModules = ["evdi"];
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
