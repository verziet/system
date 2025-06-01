inputs: let
  hosts = import ./hosts.nix;
  users = import ../homeConfigurations/users.nix;

  inherit (inputs.nixpkgs) lib;
in {
  flake.nixosConfigurations =
    lib.mapAttrs (
      hostname: host:
        lib.nixosSystem {
          inherit (host) system;

          modules = [../../hosts];
          specialArgs = {
            # pkgs passed by default
            spkgs = inputs.nixpkgs-stable.legacyPackages.${host.system};

            modules = ../../modules/nixos;
            inherit inputs hostname host users;
          };
        }
    )
    hosts;
}
