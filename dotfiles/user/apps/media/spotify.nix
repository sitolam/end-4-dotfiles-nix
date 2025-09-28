{ config, pkgs, inputs, ...}:

with config.lib.stylix.colors;

let
  spotify-cava = pkgs.writeShellScriptBin "spotify-cava" ''
    if [ $# -eq 0 ] ; then
        echo "usage: spotify-cava <spotify-window-name>"
        exit 1
    else
        spotifyTitle="$1"
    fi


    hyprctl dispatch focusworkspaceoncurrentmonitor 10

    if [ -z "$(hyprctl clients | grep "$spotifyTitle" | grep -v "grep" | grep -v "./spotify.sh")" ]; then
        hyprctl dispatch movecursor 0 0

        kitty --title "spotify cava" sh -c "exit"
        kitty --title "spotify cava" sh -c "cava" &
        sleep 0.5
        hyprctl --batch "dispatch focuswindow 'initialtitle:(spotify cava)' ; dispatch togglefloating ; dispatch resizeactive exact 50% 55% ;  dispatch centerwindow 1 ; dispatch moveactive 70% 60%"


        spotify &
        sleep 1
        until [ ! -z "$(hyprctl clients | grep "$spotifyTitle" | grep -v "grep" | grep -v "./spotify.sh")" ]
        do
        echo ""
        done
        hyprctl --batch "dispatch focuswindow "initialtitle:$spotifyTitle" ; dispatch togglefloating ; dispatch resizeactive exact 50% 55% ; dispatch centerwindow 1 ; dispatch moveactive -70% -60%" 
        sleep 3
        playerctl play-pause
    fi
    '';
in

{
  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      shuffle # shuffle+ (special characters are sanitized out of extension names)
      groupSession # Allows you to create a link to share with your friends to listen along with you.
      powerBar # Spotlight-like search bar for spotify.
      songStats # Show a song's stats, like dancability, tempo, and key.
      history # Adds a page that shows your listening history.
    ];

    enabledCustomApps = with spicePkgs.apps; [
      marketplace # Add a page where you can browse extensions, themes, apps, and snippets. Using the marketplace does not work with this flake, however it is still here in order to allow for browsing.
      localFiles # Add a shortcut to see just your local files.
      lyricsPlus # Add a page with pretty scrolling lyrics.
    ];

    theme = spicePkgs.themes.sleek;
      colorScheme = "custom";
      customColorScheme = {
        "text"               = "${magenta}";
        "subtext"            = "${base05}";
        "nav-active-text"    = "${bright-green}";
        "main"               = "${base00}";
        "sidebar"            = "${base00}";
        "player"             = "${base00}";
        "card"               = "${base00}";
        "shadow"             = "${base02}";
        "main-secondary"     = "${base01}";
        "button"             = "${orange}";
        "button-secondary"   = "${bright-cyan}";
        "button-active"      = "${orange}";
        "button-disabled"    = "${base0D}";
        "nav-active"         = "${magenta}";
        "play-button"        = "${green}";
        "tab-active"         = "${yellow}";
        "notification"       = "${blue}";
        "notification-error" = "${red}";
        "playback-bar"       = "${bright-green}";
        "misc"               = "${bright-magenta}";
      };
  };

  home.packages = with pkgs; [
    spotify-cava
  ];

}