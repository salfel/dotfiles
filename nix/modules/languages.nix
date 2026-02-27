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
    php83
    php83Packages.composer
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

    # Formatter
    alejandra
    nixfmt
    stylua
    biome
    prettier
    black
    cmake-format
    cmake-language-server
    google-java-format

    # Debuggers
    gdb

    # Dev packages
    air

    tree-sitter
  ];
}
