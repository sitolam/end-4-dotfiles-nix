{ pkgs, lib, settings, config, ... }: let
  details = settings.themeDetails;
in {

  # Stylix
  stylix = {
    enable = true;
    polarity = "dark";
    image = details.wallpaper;
    base16Scheme = lib.mkIf (details.themeName != null)
            "${pkgs.base16-schemes}/share/themes/${details.themeName}.yaml";
    override = lib.mkIf (details.override != null) details.override;    
    opacity = {
        terminal = 0.6;
        applications = 0.6;
        desktop = 0.6;
    };

    targets.hyprlock.enable = false;
    targets.btop.enable =
      lib.mkIf (settings.themeDetails.btopTheme != null) false;
  };

}