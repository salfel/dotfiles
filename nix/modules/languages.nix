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

    # Compilers
    gcc
    gnumake
    cmake

    # LSPs
    nixd
    lua-language-server
    clang-tools
    ccls
    clang
    clang-tools
    ols

    # Formatter
    alejandra
    nixfmt-classic
    stylua
    biome
    prettier
    black
    cmake-format
    cmake-language-server

    # Dev packages
    air
  ];
}
