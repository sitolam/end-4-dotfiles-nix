{ config, pkgs, ...}:


{
  home.packages = with pkgs; [
    gparted
  ];

  xdg.desktopEntries.gparted = {
    name = "GParted";
    genericName = "Partition Editor";
    comment = "Create, reorganize, and delete partitions";
    exec = "sudo -E ${pkgs.gparted}/bin/gparted %f";
    icon = "gparted";
    terminal = false;
    type = "Application";
    categories = [ "GNOME" "System" "Filesystem" ];
  };
}