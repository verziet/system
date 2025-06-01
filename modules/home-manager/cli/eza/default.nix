{
  lib,
  config,
  ...
}: let
  moduleName = "eza";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.eza = {
      enable = lib.mkForce true;

      enableZshIntegration = lib.mkIf config."zsh".enableModule (lib.mkDefault true);

      extraOptions = [
        "--icons"
        "-1"
      ];
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
