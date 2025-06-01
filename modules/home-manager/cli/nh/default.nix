{
  lib,
  config,
  ...
}: let
  moduleName = "nh";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.nh = {
      enable = lib.mkForce true;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
