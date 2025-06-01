{
  lib,
  config,
  ...
}: let
  moduleName = "bat";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.bat = {
      enable = lib.mkForce true;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
