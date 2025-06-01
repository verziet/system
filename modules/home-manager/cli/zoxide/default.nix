{
  lib,
  config,
  ...
}: let
  moduleName = "zoxide";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.zoxide = {
      enable = lib.mkForce true;

      enableZshIntegration = lib.mkIf config."zsh".enableModule (lib.mkDefault true);

      options = [
        "--cmd j"
      ];
    };

    home.sessionVariables = lib.mkIf config."fzf".enableModule {
      _ZO_FZF_OPTS = "--height=100% --layout=reverse";
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
