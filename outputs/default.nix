inputs @ {...}:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

  imports = [
    inputs.git-hooks-nix.flakeModule
  ];

  perSystem = {
    config,
    pkgs,
    self',
    ...
  }: {
    pre-commit.settings.hooks = {
      alejandra.enable = true;
      statix.enable = true;
      deadnix.enable = true;
      nil.enable = true;
      typos.enable = true;
      commitizen.enable = true;
    };

    formatter = pkgs.alejandra;

    packages.install-git-hooks = pkgs.writeShellScriptBin "install-git-hooks" config.pre-commit.installationScript;

    apps.install-git-hooks = {
      meta.description = "Installs git hooks defined in pre-commit";
      program = "${self'.packages.install-git-hooks}/bin/install-git-hooks";
      type = "app";
    };
  };
}
