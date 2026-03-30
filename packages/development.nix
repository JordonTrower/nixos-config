{
  pkgs,
  ...
}:

{

  environment.systemPackages = with pkgs; [
    vim
    docker
    lazygit
    lazydocker
    neovim
    kitty
    ghostty
    tmux
    git
    ripgrep
    godot
    #languages
    asdf-vm
    rustc
    rustup
    dioxus-cli
    lua
    clang
    dotnet-sdk
    # language servers / prettiers
    stylua
    nixd
    prettierd
    typescript-language-server
    nixfmt
    clang-tools
    rust-analyzer
    rustfmt
    csharp-ls
    lua-language-server
    # New formatters
    black
    isort
    shfmt
    jsonfmt
    # New LSP servers
    bash-language-server
  ];
}
