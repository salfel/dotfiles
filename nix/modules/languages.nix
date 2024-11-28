{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Languages
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
    ccls

    # Formatter
    rustfmt
    nixfmt-classic
    stylua

    # Dev packages
    air
  ];
}
