_: {
  perSystem = _: {
    pre-commit.settings.hooks = {
      alejandra.enable = true;
      statix.enable = true;
      deadnix.enable = true;
      nil.enable = true;
      typos.enable = true;
      commitizen.enable = true;
    };
  };
}
