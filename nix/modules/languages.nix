{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Languages
    python3
    python3Packages.pip
    nodejs
    pnpm
    yarn
    bun
    go
    php
    phpPackages.composer
    cargo
    zig
    rustup
    odin
    jdk25

    # Compilers
    gcc
    gnumake
    cmake
    fpc

    # LSPs
    nixd
    lua-language-server
    clang-tools
    ccls
    clang
    clang-tools
    ols
    jdt-language-server
    texlab
    intelephense

    # Formatter
    alejandra
    nixfmt
    stylua
    biome
    prettier
    black
    cmake-format
    cmake-language-server
    blade-formatter

    # Build tools
    pkg-config

    # Debuggers
    gdb

    # Package managers
    uv

    # Dev packages
    air
    laravel
  ];
}
