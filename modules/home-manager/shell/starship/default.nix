{
  lib,
  config,
  ...
}: let
  moduleName = "starship";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.starship = {
      enable = lib.mkForce true;

      enableZshIntegration = lib.mkIf config."zsh".enableModule (lib.mkDefault true);
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
