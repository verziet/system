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
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    programs.uwsm.enable = lib.mkForce true;
    programs.hyprland = {
      enable = lib.mkForce true;
      withUWSM = lib.mkForce true;

      package = lib.mkDefault inputs.hyprland.packages.${host.system}.hyprland;
      portalPackage = lib.mkDefault inputs.hyprland.packages.${host.system}.xdg-desktop-portal-hyprland;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
