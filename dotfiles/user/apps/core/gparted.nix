{ config, pkgs, ...}:

let
  gparted-fix = pkgs.writeShellScriptBin "gparted-fix" ''
    pkexec bash -c "ln -s /home/$USER/.themes /root; env GTK_THEME="adw-gtk3" XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR WAYLAND_DISPLAY=$WAYLAND_DISPLAY ${pkgs.gparted}/bin/gparted"
    '';
in

{
  home.packages = with pkgs; [
    gparted
    gparted-fix
  ];

  xdg.desktopEntries.gparted = {
    name = "GParted";
    genericName = "Partition Editor";
    comment = "Create, reorganize, and delete partitions";
    exec = "gparted-fix";
    icon = "gparted";
    terminal = false;
    type = "Application";
    categories = [ "GNOME" "System" "Filesystem" ];
  };

}