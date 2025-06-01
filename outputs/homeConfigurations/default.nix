inputs: let
  users = import ./users.nix;
  hosts = import ../nixosConfigurations/hosts.nix;

  getHostname = username: lib.elemAt (lib.splitString "@" username) 1;
  getHost = username: hosts.${getHostname username};

  inherit (inputs.nixpkgs) lib;
in {
  flake.homeConfigurations =
    lib.mapAttrs (
      username: user:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.${(getHost username).system};

          modules = [../../users];
          extraSpecialArgs = {
            # pkgs passed by default
            spkgs = inputs.nixpkgs-stable.legacyPackages.${(getHost username).system};

            modules = ../../modules/home-manager;

            username = lib.elemAt (lib.splitString "@" username) 0;
            hostname = getHostname username;
            host = getHost username;

            inherit user inputs;
          };
        }
    )
    users;
}
