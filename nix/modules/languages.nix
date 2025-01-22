{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Languages
    python3
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

    # Compilers
    gcc
    gnumake
    cmake

    # LSPs
    nixd
    lua-language-server
    clang-tools
    ccls

    # Formatter
    nixfmt-classic
    stylua
    biome

    # Dev packages
    air
  ];
}
