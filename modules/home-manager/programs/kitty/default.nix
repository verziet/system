{
  pkgs,
  lib,
  config,
  ...
}: let
  moduleName = "kitty";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.kitty = {
      enable = lib.mkForce true;

      font = {
        name = lib.mkDefault "RecMonoLinear Nerd Font";
        package = lib.mkDefault pkgs.nerd-fonts.recursive-mono;
      };

      settings = {
        cursor_trail = lib.mkDefault 1;
      };
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
