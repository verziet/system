{
  lib,
  hostname,
  host,
  username,
  ...
}: let
  usernameHostname = "${username}@${hostname}";
in {
  imports = [
    ./${usernameHostname}/home.nix
    ./${usernameHostname}/packages.nix
  ];

  home = {
    username = lib.mkDefault "${username}";
    homeDirectory = lib.mkDefault "/home/${username}";
  };

  nixpkgs.config.allowUnfree = lib.mkDefault true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = host.stateVersion;
}
