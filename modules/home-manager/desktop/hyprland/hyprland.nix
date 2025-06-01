lib: {
  "$mainMod" = "SUPER";
  "$terminal" = "kitty";

  monitor = lib.mkDefault [
    # TODO
    "desc:Chimei Innolux Corporation 0x1521, 1920x1080@144, 0x0, 1.2"
    "desc:Microstep MSI G27CQ4 0x000008D3,2560x1440@120,-320x-1440,1"
    "desc:Vestel Elektronik Sanayi ve Ticaret A. S. 24W_LCD_TV,1920x1080@60,-1400x-1440,1,transform,1"
  ];

  general = lib.mkDefault {
    gaps_in = lib.mkDefault 5;
    gaps_out = lib.mkDefault 10;

    border_size = lib.mkDefault 1;

    "col.active_border" = lib.mkDefault "rgba(00000000)";
    "col.inactive_border" = lib.mkDefault "rgba(00000000)";

    resize_on_border = lib.mkDefault true;

    allow_tearing = lib.mkDefault false;
    layout = lib.mkDefault "dwindle";
  };

  decoration = lib.mkDefault {
    rounding = lib.mkDefault 0;

    active_opacity = lib.mkDefault 1.0;
    inactive_opacity = lib.mkDefault 1.0;

    shadow.enabled = lib.mkDefault false;
    blur.enabled = lib.mkDefault false;
  };

  animations = lib.mkDefault {
    enabled = lib.mkDefault true;

    # Animation curves
    bezier = [
      "linear, 0, 0, 1, 1"
      "md3_standard, 0.2, 0, 0, 1"
      "md3_decel, 0.05, 0.7, 0.1, 1"
      "md3_accel, 0.3, 0, 0.8, 0.15"
      "overshot, 0.05, 0.9, 0.1, 1.1"
      "crazyshot, 0.1, 1.5, 0.76, 0.92 "
      "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
      "menu_decel, 0.1, 1, 0, 1"
      "menu_accel, 0.38, 0.04, 1, 0.07"
      "easeInOutCirc, 0.85, 0, 0.15, 1"
      "easeOutCirc, 0, 0.55, 0.45, 1"
      "easeOutExpo, 0.16, 1, 0.3, 1"
      "softAcDecel, 0.26, 0.26, 0.15, 1"
      "md2, 0.4, 0, 0.2, 1ion"
    ];

    # Animation configs
    animation = [
      "windows, 1, 3, md3_decel, popin 60%"
      "windowsIn, 1, 3, md3_decel, popin 60%"
      "windowsOut, 1, 3, md3_accel, popin 60%"
      "border, 1, 10, default"
      "fade, 1, 3, md3_decel"
      "layersIn, 1, 3, menu_decel, slide"
      "layersOut, 1, 1.6, menu_accel"
      "fadeLayersIn, 1, 2, menu_decel"
      "fadeLayersOut, 1, 0.5, menu_accel"
      "workspaces, 1, 7, menu_decel, slide"
      "specialWorkspace, 1, 3, md3_decel, slidevert"
    ];

    #layers, 1, 2, md3_decel, slide
    #workspaces, 1, 2.5, softAcDecel, slide
    #workspaces, 1, 7, menu_decel, slidefade 15%
    #specialWorkspace, 1, 3, md3_decel, slidefadevert 15%
  };

  dwindle = lib.mkDefault {
    pseudotile = lib.mkDefault true;
    preserve_split = lib.mkDefault true;
  };

  misc = lib.mkDefault {
    force_default_wallpaper = lib.mkDefault 0;
    disable_hyprland_logo = lib.mkDefault true;
  };

  input = lib.mkDefault {
    kb_layout = lib.mkDefault "us";

    follow_mouse = lib.mkDefault 1;

    sensitivity = lib.mkDefault 0;
    repeat_delay = lib.mkDefault 250;

    touchpad.natural_scroll = lib.mkDefault true;
  };

  gestures = lib.mkDefault {
    #TODO
    workspace_swipe = lib.mkDefault true;
    workspace_swipe_invert = lib.mkDefault false;
    workspace_swipe_forever = lib.mkDefault true;
  };

  windowrulev2 = lib.mkDefault [
    "suppressevent maximize, class:.*"
    "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
  ];

  bind = lib.mkDefault [
    "$mainMod,       Q, exec, $terminal"
    "$mainMod,       C, killactive,"
    "$mainMod,       M, exit,"
    "$mainMod,       F, togglefloating,"
    "$mainMod,       P, pseudo,"
    "$mainMod,       J, togglesplit,"

    # Moving focus
    "$mainMod, H, movefocus, l"
    "$mainMod, L, movefocus, r"
    "$mainMod, K, movefocus, u"
    "$mainMod, J, movefocus, d"
    "$mainMod, U, exec, hyprshot -m region"

    "$mainMod, 1, workspace, 1"
    "$mainMod, 2, workspace, 2"
    "$mainMod, 3, workspace, 3"
    "$mainMod, 4, workspace, 4"
    "$mainMod, 5, workspace, 5"

    # Moving windows
    "$mainMod CTRL, H,  swapwindow, l"
    "$mainMod CTRL, L, swapwindow, r"
    "$mainMod CTRL, K,    swapwindow, u"
    "$mainMod CTRL, J,  swapwindow, d"

    # Resizing windows                   X  Y
    "$mainMod SHIFT, H,  resizeactive, -60 0"
    "$mainMod SHIFT, L, resizeactive,  60 0"
    "$mainMod SHIFT, K,    resizeactive,  0 -60"
    "$mainMod SHIFT, J,  resizeactive,  0  60"

    # Switching monitors
    "Super_R&Alt_R&Shift_R, 1, focusmonitor, desc:Chimei Innolux Corporation 0x1521"
    "Super_R&Alt_R&Shift_R, 2, focusmonitor, desc:Microstep MSI G27CQ4 0x000008D3"
    "Super_R&Alt_R&Shift_R, 3, focusmonitor, desc:Vestel Elektronik Sanayi ve Ticaret A. S. 24W_LCD_TV"

    # Scratchpad
    "$mainMod,       S, togglespecialworkspace,  magic"
  ];

  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = lib.mkDefault [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  # Laptop multimedia keys for volume and LCD brightness
  bindel = lib.mkDefault [
    ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86MonBrightnessUp,   exec, brightnessctl s 5%+"
    ",XF86MonBrightnessDown, exec, brightnessctl s 5%- -n 1"
  ];

  bindl = lib.mkDefault [
    ",XF86AudioNext,  exec, playerctl next"
    ",XF86AudioPause, exec, playerctl play-pause"
    ",XF86AudioPlay,    exec, playerctl play-pause"
    ",XF86AudioPrev,    exec, playerctl previous"
    ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
  ];
}
