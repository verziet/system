{
  lib,
  config,
  ...
}: let
  moduleName = "fzf";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.fzf = {
      enable = lib.mkForce true;

      enableZshIntegration = lib.mkIf config."zsh".enableModule (lib.mkDefault true);

      defaultOptions = lib.mkDefault [
        "--height 100%"
        "--layout=reverse"
      ];
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
