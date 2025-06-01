{modules, ...}: {
  imports = [
    "${modules}/desktop/gnome"

    "${modules}/hardware/bluetooth"
    "${modules}/hardware/pipewire"
    "${modules}/hardware/nvidia"
    "${modules}/hardware/displaylink"

    "${modules}/services/kanata"
    "${modules}/services/clamav"
  ];

  #console = {
  #  font = "RecMonoLinear Nerd Font";

  #  packages = with pkgs; [
  #    nerd-fonts.recursive-mono
  #  ];
  #};
}
