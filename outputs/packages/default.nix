_: {
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    packages = {
      install-git-hooks = pkgs.writeShellScriptBin "install-git-hooks" config.pre-commit.installationScript;
    };
  };
}
