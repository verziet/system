_: {
  perSystem = {self', ...}: {
    apps = {
      install-git-hooks = {
        meta.description = "Installs git hooks defined in checks";
        program = "${self'.packages.install-git-hooks}/bin/install-git-hooks";
        type = "app";
      };
    };
  };
}
