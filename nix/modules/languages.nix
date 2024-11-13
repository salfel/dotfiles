{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python3
    nodejs
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
  ];
}
