{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      droidcam-obs
      obs-backgroundremoval
      input-overlay
      obs-move-transition
      obs-replay-source
      obs-websocket
    ];
  };

}