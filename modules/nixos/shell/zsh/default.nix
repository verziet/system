{
  lib,
  config,
  ...
}: let
  moduleName = "zsh";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.zsh.enable = lib.mkForce true;
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
