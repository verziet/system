{
  lib,
  config,
  ...
}: let
  moduleName = "ssh";
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    services.openssh = {
      enable = lib.mkForce true;
      ports = lib.mkDefault [22];

      settings = {
        PasswordAuthentication = lib.mkDefault true;
        AllowUsers = lib.mkDefault null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = lib.mkDefault true;
        X11Forwarding = lib.mkDefault false;
        PermitRootLogin = lib.mkDefault "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
