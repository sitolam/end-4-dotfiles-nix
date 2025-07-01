{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # Install plugins
    plugins = with pkgs.vimPlugins; [
      # Plugin manager
      lazy-nvim

      # Core plugins that might be needed
      nvim-treesitter
      telescope-nvim
      nvim-lspconfig
      nvim-cmp
      mason-nvim
      nvim-tree-lua
      rust-tools-nvim
    ];

    # Configure Neovim
    extraConfig = ''
      -- Load the configuration from the nvim directory
      vim.opt.runtimepath:append("${config.xdg.configHome}/nvim")
      require("core")
    '';

    # Copy configuration files to the proper location
    extraPackages = with pkgs; [
      # LSP servers, formatters, and linters
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      lua-language-server
      rust-analyzer
      ripgrep
      fd
    ];
  };

  # Copy the nvim configuration directory to ~/.config/nvim
  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}