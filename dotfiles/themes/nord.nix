{ dir }:
{
    themeName = "nord";
    wallpaper = ../non-nix/wallpapers/nord.png;
    override = {
        base02 = "#445060";
        base05 = "#fffcf0";
    };

    # Override stylix theme of btop.
    btopTheme = "nord";

}