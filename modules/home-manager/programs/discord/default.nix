{
  inputs,
  lib,
  config,
  ...
}: let
  moduleName = "discord";
in {
  imports = [inputs.nixcord.homeModules.default];

  config = lib.mkIf config.${moduleName}.enableModule {
    programs.nixcord = {
      enable = lib.mkForce true; # enable Nixcord. Also installs discord package

      quickCss = lib.mkDefault ""; # quickCSS file

      config = {
        useQuickCss = lib.mkDefault false; # use out quickCSS
        frameless = lib.mkDefault true; # set some Vencord options

        plugins = lib.mkDefault {
          hideAttachments.enable = true; # Enable a Vencord plugin
          /*
            ignoreActivities = {    # Enable a plugin and set some options
            enable = true;
            ignorePlaying = true;
            ignoreWatching = true;
            ignoredActivities = [ "someActivity" ];
          };
          */
        };

        themeLinks = lib.mkDefault [
          #"https://raw.githubusercontent.com/refact0r/system24/refs/heads/main/theme/system24.theme.css"
        ];
      };

      extraConfig = lib.mkDefault {
        # Some extra JSON config here
        # ...
      };
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
