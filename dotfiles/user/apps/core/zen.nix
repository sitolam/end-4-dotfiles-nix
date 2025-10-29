{ config, pkgs, inputs, settings, ...}:
{
  programs.zen-browser = {
    enable = true;
    profiles."default" = {
      spacesForce = true;
      spaces = let
        containers = config.programs.zen-browser.profiles."default".containers;
      in {
        "Personal" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40a";
          icon = "🏠";
          position = 1000;
        };
        "School" = {
          id = "cdd10fab-4fc5-494b-9041-325e5759195b";
          icon = "🎓";
          position = 2000;
        };
        "Entertainment" = {
          id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc25";
          icon = "🎮";
          position = 3000;
        };
        "Shopping" = {
          id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
          icon = "💸";
          position = 4000;
        };
      };
      search = {
        default = "DuckDuckGo";
      };
    };
    policies = {
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisableAppUpdate = true;
      DisableMasterPasswordCreation = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;

      ExtensionSettings = 
        let
          moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
        in
        {
          "uBlock0@raymondhill.net" = {
            install_url = moz "ublock-origin";
            installation_mode = "force_installed";
            default_area = "menupanel";
            private_browsing = true;
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = moz "bitwarden-password-manager";
            installation_mode = "force_installed";
            default_area = "navbar";
            private_browsing = true;
        };
        "enhancerforyoutube@maximerf.addons.mozilla.org" = {
            install_url = moz "enhancer-for-youtube";
            installation_mode = "force_installed";
            default_area = "menupanel";
            private_browsing = true;
          };
          "github-repo-size@gmail.com" = {
            install_url = moz "github-repo-size-extension";
            installation_mode = "force_installed";
            default_area = "menupanel";
            private_browsing = true;
          };
          "gitzip-firefox-addons@gitzip.org" = {
            install_url = moz "gitzip";
            installation_mode = "force_installed";
            default_area = "menupanel";
            private_browsing = true;
          };
          "{1b84391e-7c49-4ff3-abab-07bd0a4523e4}" = {
            install_url = moz "multiselect-for-youtube";
            installation_mode = "force_installed";
            default_area = "menupanel";
            private_browsing = true;
          };
          "{jid0-YQz0l1jthOIz179ehuitYAOdBEs@jetpack}" = {
            install_url = moz "print-friendly-and-pdf";
            installation_mode = "force_installed";
            default_area = "menupanel";
            private_browsing = true;
          };
          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = {
            install_url = moz "refined-github-";
            installation_mode = "force_installed";
            default_area = "menupanel";
            private_browsing = true;
          };
          "{30b15d56-b2fa-4cb2-98fd-7b5e26306483}" = {
            install_url = moz "stayfree";
            installation_mode = "force_installed";
            default_area = "menupanel";
            private_browsing = true;
          };
          "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
            install_url = moz "user-agent-string-switcher";
            installation_mode = "force_installed";
            default_area = "menupanel";
            private_browsing = true;
          };
          "sponsorBlocker@ajay.app" = {
            install_url = moz "sponsorblock";
            installation_mode = "force_installed";
            default_area = "menupanel";
            private_browsing = true;
          };
        };
      };
    };


  # Set Zen Browser as the default application for various MIME types
  xdg.mimeApps = let
    value = let
      zen-browser = inputs.zen-browser.packages.${settings.system}.beta; # or twilight
    in
      zen-browser.meta.desktopFileName;

    associations = builtins.listToAttrs (map (name: {
        inherit name value;
      }) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "text/plain"
        "text/html"
        "application/pdf"
      ]);
  in {
    associations.added = associations;
    defaultApplications = associations;
  };

}