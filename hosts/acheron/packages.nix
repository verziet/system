{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.recursive-mono
  ];
}
