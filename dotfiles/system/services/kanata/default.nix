{ config, lib, pkgs, settings, ... }:

let
  toggle-kanata = pkgs.writeShellScriptBin "toggle-kanata" ''
    # Check the status of the kanata-default.service
    if systemctl is-active --quiet kanata-default.service; then
      systemctl stop kanata-default.service
      notify-send -a 't1' -i "dialog-information" "Kanata off"
    else
      systemctl start kanata-default.service
      notify-send -a 't1' -i "dialog-information" "Kanata on"
    fi
  '';
in

{

  # Enable the uinput module
  boot.kernelModules = [ "uinput" ];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  # Enable Kanata service
  services.kanata = {
      enable = true;
      keyboards = {
        # NOTE name keyboard (see options: https://mynixos.com/nixpkgs/options/services.kanata.keyboards.%3Cname%3E)
        default = {
          devices = [
            # NOTE all devices if empty
          ];
          extraDefCfg = ''
            log-layer-changes no
            process-unmapped-keys yes ;; nodig zodat bij caps-word alle letters captital + dan werk tap-hold beter
            concurrent-tap-hold yes
          '';
          config = builtins.readFile ./config.kbd;
        };
      };
    };

  home-manager.users.${settings.username}.home.packages = with pkgs; [
    toggle-kanata
  ];
}