{
  lib,
  pkgs,
  inputs,
  modules,
  hostname,
  host,
  users,
  ...
}: {
  imports =
    [
      # modules
      "${modules}/bootloader/grub"
      "${modules}/shell/zsh"

      "${modules}/cli/git"

      "${modules}/hardware/networkmanager"

      "${modules}/services/firewall"
      "${modules}/services/ssh"
    ]
    ++ [
      ./${hostname}/configuration.nix
      ./${hostname}/packages.nix
      ./${hostname}/hardware.nix
    ];

  environment.systemPackages = [pkgs.home-manager];

  users.defaultUserShell = lib.mkOverride 999 pkgs.zsh;
  fonts.enableDefaultPackages = lib.mkDefault true;

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 1w";
  };

  users.users = lib.mapAttrs' (username: user:
    lib.nameValuePair (lib.elemAt (lib.splitString "@" username) 0) {
      isNormalUser = lib.mkDefault true;
      initialPassword = lib.mkDefault "";
      extraGroups = lib.mkDefault user.groups;
    })
  users;

  nixpkgs.config.allowUnfree = lib.mkDefault true;
  environment = {
    variables.NIXPKGS_ALLOW_UNFREE = 1;

    etc."nix/inputs/nixpkgs".source = lib.mkDefault "${inputs.nixpkgs}";
  };

  nix = {
    channel.enable = lib.mkDefault false;

    registry = {
      pkgs.flake = lib.mkDefault inputs.nixpkgs;
      spkgs.flake = lib.mkDefault inputs.nixpkgs-stable;
    };

    settings = {
      experimental-features = lib.mkDefault ["flakes" "nix-command" "pipe-operators"];
      flake-registry = lib.mkDefault "";

      auto-optimise-store = lib.mkDefault true;

      # https://github.com/NixOS/nix/issues/9574
      nix-path = lib.mkDefault "nixpkgs=/etc/nix/inputs/nixpkgs";
    };
  };

  networking.hostName = lib.mkDefault "${hostname}";

  system.stateVersion = host.stateVersion;
}
