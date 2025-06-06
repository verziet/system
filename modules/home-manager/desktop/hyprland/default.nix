{
  inputs,
  lib,
  config,
  host,
  ...
}: let
  moduleName = "hyprland";
in {
  config = lib.mkIf config."hyprland".enableModule {
    home.file = {
      ".config/uwsm/env" = {
        text = ''
          export XDG_CURRENT_DESKTOP=Hyprland
          export NIXOS_OZONE_WL=1

          export QT_AUTO_SCREEN_SCALE_FACTOR=1
          export QT_QPA_PLATFORM=wayland;xcb
          export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
          export QT_QPA_PLATFORMTHEME=qt5ct
        '';
      };
    };

    wayland.windowManager.hyprland = {
      enable = lib.mkForce true;

      settings = import ./hyprland.nix lib;

      systemd.enable = lib.mkForce false; # Required for Hyprland UWSM
      package = lib.mkDefault inputs.hyprland.packages.${host.system}.hyprland;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
