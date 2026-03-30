# Server-related packages for tools like nvim, wget, curl, etc
{ pkgs, ... }:
with pkgs;
[
  # Text editors and IDE tools
  neovim
  ripgrep
  fd
  tree

  # Networking tools
  wget
  curl
  httpie
  jq

  # System utilities
  btop
  htop
  tmux

  # Development tools
  git
  git-lfs
  gh

  # File management
  yazi
  ghostty

  # Build tools
  nix
  nixFlakes.nixFlakes

  qwen-code

  # Shell
  zsh
]
