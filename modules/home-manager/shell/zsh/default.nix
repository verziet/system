{
  lib,
  config,
  ...
}: let
  moduleName = "zsh";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.zsh = {
      enable = lib.mkForce true;

      syntaxHighlighting.enable = lib.mkDefault true;

      shellAliases = lib.mkMerge [
        {
          l = "ls -l";
          ll = "ls -l -A";
        }
        (lib.mkIf config."bat".enableModule {
          cat = "bat -p";
        })
      ];

      initContent = ''
        bindkey "^H" backward-kill-word
        bindkey "5~" kill-word
      '';

      history = {
        extended = lib.mkDefault true;
        path = lib.mkDefault "${config.xdg.dataHome}/zsh/history";
        size = lib.mkDefault 10000;
      };
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
