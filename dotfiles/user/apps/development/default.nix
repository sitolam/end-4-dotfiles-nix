{ config, pkgs, ...}:
{

  imports = [
    ./vscode.nix
    ./flutter.nix
    ./neovim/nvim.nix
  ];
}