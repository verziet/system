{
  lib,
  config,
  ...
}: let
  moduleName = "mcfly";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.mcfly = {
      enable = lib.mkForce true;

      enableZshIntegration = lib.mkIf config."zsh".enableModule (lib.mkDefault true);
      fzf.enable = lib.mkIf config."fzf".enableModule (lib.mkDefault true);

      keyScheme = lib.mkDefault "vim";
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
