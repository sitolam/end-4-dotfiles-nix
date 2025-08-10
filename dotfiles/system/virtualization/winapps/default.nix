{ config, pkgs, settings, winapps, ...}:

let
  toggle-windows = pkgs.writeShellScriptBin "toggle-windows" ''
    # Check the status of the kanata-default.service
    if systemctl is-active --quiet docker-compose-winapps-root.target; then
      systemctl stop docker-compose-winapps-root.target
      notify-send -a 't1' -i "dialog-information" "Windows off"
    else
      systemctl start docker-compose-winapps-root.target
      notify-send -a 't1' -i "dialog-information" "Windows on"
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