{
  pkgs,
  ...
}:
{
  gtk = {
    enable = true;
    theme = {
      name = "Graphite-Dark";
      package = pkgs.graphite-gtk-theme.override {
        tweaks = [ "darker" ];
        themeVariants = [ "pink" ];
        colorVariants = [ "dark" ];
      };
    };
  };
}
