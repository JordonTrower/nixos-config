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
        "eDP-1,2560x1440@165,0x0,1.6"
      ];

      exec-once = [
        "caelestia shell -d"
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
        "$mod, RETURN, exec, $terminal -e zsh -c \"source ~/.zprofile && source ~/.zshrc && tmux; exit\""
        "$mod, SPACE, exec, rofi -show drun"
        "$mod, F, exec, $terminal -e zsh -c \"source ~/.zprofile && source ~/.zshrc && yazi; exit\""
        "$mod, B, exec, floorp"
        # Workspaces
        "$mod, SHIFT TAB, workspace, previous"
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
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
