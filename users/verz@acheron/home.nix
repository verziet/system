{modules, ...}: {
  imports = [
    "${modules}/desktop/hyprland"

    "${modules}/shell/zsh"
    "${modules}/shell/starship"

    "${modules}/cli/nh"
    "${modules}/cli/zoxide"
    "${modules}/cli/fzf"
    "${modules}/cli/mcfly"
    "${modules}/cli/eza"
    "${modules}/cli/bat"

    "${modules}/programs/kitty"
    "${modules}/programs/spotify"
    "${modules}/programs/discord"
  ];
}
