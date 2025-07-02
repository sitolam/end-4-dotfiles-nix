{ pkgs, unstable, ... }:

{
  programs.gpu-screen-recorder.enable = true;

  environment.systemPackages = with pkgs; [
    unstable.gpu-screen-recorder-gtk
  ];
}