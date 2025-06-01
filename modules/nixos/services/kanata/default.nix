{
  pkgs,
  lib,
  config,
  ...
}: let
  moduleName = "kanata";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    environment.systemPackages = with pkgs; [
      playerctl
      brightnessctl
      wireplumber
    ];

    services.kanata = {
      enable = lib.mkForce true;
      package = lib.mkDefault pkgs.kanata-with-cmd;

      keyboards.internalKeyboard = {
        devices = [];

        extraDefCfg = ''
          danger-enable-cmd yes ;; enable commands
          process-unmapped-keys yes ;; keys undefined in defsrc will be processed
          block-unmapped-keys yes ;; keys undefined in defsrc will be blocked
        '';

        config = lib.readFile ./kanata.kbd;
      };
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
