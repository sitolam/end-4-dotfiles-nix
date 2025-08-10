{ config, pkgs, settings, ... }:

let
  update = pkgs.writeShellScriptBin "update" ''
    env NH_FLAKE="$NH_FLAKE"
    nh os switch
    if [ $? -ne 0 ]; then
        notify-send "Error" "Failed to switch NixOS configuration."
    else
        notify-send "Success" "NixOS configuration switched successfully."
    fi
    read -n 1 -p 'Press any key to continue...'
    '';
in

{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 2";
    flake = settings.dotfilesDir;
  };

  home-manager.users.${settings.username}.home.packages = with pkgs; [
    update
  ];
}