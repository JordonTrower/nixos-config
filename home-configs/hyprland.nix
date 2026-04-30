{
  config,
  lib,
  pkgs,
  ...
}:

{

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "ALT";
      "$terminal" = "ghostty";

      general = {
        gaps_in = "4";
        gaps_out = "8";
      };

      xwayland = {
        force_zero_scaling = true;
        use_nearest_neighbor = true;
      };

      monitor = [
        # "eDP-1,2560x1440@165,0x0,1.6"
        "HDMI-A-1,3840x2160@120,2560x0,1.2"
        "DP-1,2560x1440@99.95,0x0,1"
      ];

      exec-once = [
        "caelestia shell -d"
        "noctalia-shell -d"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        #tabs
        "$mod, TAB, cyclenext, bringactivetotop"
        "$mod, W, killactive"
        #Applications
        "$mod, RETURN, exec, $terminal"
        "$mod, SPACE, exec, fuzzel"
        "$mod, F, exec, $terminal -e zsh -c \"yazi; exit\""
        "$mod, B, exec, floorp"
        # Workspaces
        "$mod, SHIFT TAB, workspace, previous"
        "SHIFT $mod, F, fullscreen"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));
    };
    extraConfig = ''
      bind = $mod, O, submap, clean
      submap = clean
      bind = $mod, P, submap, reset
      submap = reset
    '';
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
