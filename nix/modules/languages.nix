{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python3
    nodejs
    yarn
    go
    php83
    php83Packages.composer
    cargo

    # Compilers
    gcc
    gnumake
    cmake
    rustc

    # LSPs
    rust-analyzer
    nixd
    lua-language-server
    clang-tools

    # Formatter
    rustfmt
    nixfmt-classic
    stylua
  ];
}
