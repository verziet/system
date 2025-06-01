inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  systems = ["x86_64-linux"];

  imports =
    [
      inputs.git-hooks-nix.flakeModule
    ]
    ++ [
      (import ./homeConfigurations inputs)
      (import ./nixosConfigurations inputs)
      ./apps
      ./packages
      ./checks
      ./formatter
    ];
}
