{
  lib,
  config,
  ...
}: let
  moduleName = "git";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.git.enable = lib.mkForce true;
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
