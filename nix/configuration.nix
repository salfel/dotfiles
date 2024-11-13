{ pkgs, inputs, system, lib, ... }:

{
  imports =
    [
      ./modules/languages.nix
    ];

  nixpkgs.overlays = [
    (import ./overlays/easyeda2kicad.nix)
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  security.polkit.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,de";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # shells
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true; 

  users.users.felix = {
    isNormalUser = true;
    description = "Felix Salcher";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    tmux
    neovim
    kitty
    starship
    waybar
    ulauncher
    hyprshot
    hyprpaper
    hypridle
    hyprlock
    hyprcursor
    wl-clipboard
    inputs.zen-browser.packages."${system}".specific
    lazygit
    spotify
    kicad
    pulseaudio
    obsidian
    gh
    brightnessctl
    btop
    wineWowPackages.stable
    playerctl
    libreoffice
    gnome-tweaks
    fzf
    ripgrep
    ncurses
    beekeeper-studio
    vscode
    platformio
    easyeda2kicad
    unzip
    wofi
    fastfetch
    nerdfetch
    neofetch
    swaynotificationcenter
    yazi
    bruno
    chromium
    stow
    kanata
  ];

  fonts.packages = with pkgs; [ 
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  services.udev.packages = with pkgs; [ 
    platformio-core
    platformio-core.udev
    openocd
  ];

  # 1password
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password-gui"
    "1password"
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "felix" ];
  };

  programs.steam.enable = true;

  programs.hyprland.enable = true;

  virtualisation.docker.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "24.05";
}
