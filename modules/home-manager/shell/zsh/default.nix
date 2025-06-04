{
  lib,
  config,
  pkgs,
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

      initContent = lib.readFile ./zshrc;

      history = {
        extended = lib.mkDefault true;
        path = lib.mkDefault "${config.xdg.dataHome}/zsh/history";
        size = lib.mkDefault 10000;
      };
    };

    # for commands in zshrc
    home.packages = with pkgs; [
      nix-output-monitor
      nh
    ];
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
