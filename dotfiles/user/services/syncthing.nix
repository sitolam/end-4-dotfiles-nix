{ config, pkgs, settings, ...}:
{
    # Syncthing dashboard is available at http://localhost:8384
    services = {
        syncthing = {
            enable = true;
            overrideDevices = true;     # overrides any devices added or deleted through the WebUI
            overrideFolders = true;     # overrides any folders added or deleted through the WebUI
            settings = {
                devices = {
                    "laxoi-server" = { id = settings.syncthing_ID; };
                };
                folders = {
                    "anki-addons" = {
                        path = "/home/${settings.username}/.local/share/Anki2/addons21";
                        devices = [
                            "laxoi-server"
                        ];
                    };
                };
            };
        };
    };
}