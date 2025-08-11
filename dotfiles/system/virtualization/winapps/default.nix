{ config, pkgs, settings, winapps, ...}:

let
  toggle-windows = pkgs.writeShellScriptBin "toggle-windows" ''
    # Check the status of the docker-WinApps.service
    if systemctl is-active --quiet docker-WinApps.service; then
      systemctl stop docker-WinApps.service
      if [ $? -ne 0 ]; then
        notify-send "Error" "Failed to turn Windows off."
      else
          notify-send "Success" "Windows off"
      fi
    else
      systemctl start docker-WinApps.service
      if [ $? -ne 0 ]; then
        notify-send "Error" "Failed to turn Windows on."
      else
          notify-send "Success" "Windows on"
      fi
    fi
  '';
in

{

  imports = [
    ./../docker.nix
    ./windows.nix
    ];

  environment.systemPackages = [
    winapps.packages."${settings.system}".winapps
    winapps.packages."${settings.system}".winapps-launcher # optional
  ];

  home-manager.users.${settings.username}.home = {
    file."/home/${settings.username}/.config/winapps/winapps.conf".source = ./winapps.conf;

    packages = with pkgs; [
    toggle-windows
    ];
  };

}