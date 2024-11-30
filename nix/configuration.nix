{ pkgs, inputs, system, lib, ... }:

{
  imports = [ ./modules ];

  nixpkgs.overlays = [ (import ./overlays/easyeda2kicad.nix) ];

  boot = {
    # Kernel version
    kernelPackages = pkgs.linuxPackages_6_12;

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

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
  security.pam.services.gdm.enableGnomeKeyring = true;
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
  };

  # shells
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  users.users.felix = {
    isNormalUser = true;
    description = "Felix Salcher";
    extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Desktop Utilities
    waybar
    ulauncher
    wofi
    hyprshot
    hyprpaper
    hypridle
    hyprlock
    hyprcursor
    wl-clipboard
    pulseaudio
    brightnessctl
    playerctl
    swaynotificationcenter

    # Apps
    spotify
    discord
    libreoffice
    obsidian
    inputs.zen-browser.packages."${system}".specific
    chromium
    discord

    # Terminal utilities
    tmux
    tmuxinator
    neovim
    kitty
    starship
    lazygit
    btop
    yazi
    fastfetch
    stow
    unzip
    fzf
    ripgrep
    cloc

    # Dev Apps
    beekeeper-studio
    vscode
    bruno
    postman
  ];

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  # 1password
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "1password-gui" "1password" ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "felix" ];
  };

  programs.steam.enable = true;

  programs.hyprland.enable = true;

  virtualisation = {
    docker.enable = true;

    virtualbox.host.enable = true;
    virtualbox.guest.enable = true;
    virtualbox.guest.dragAndDrop = true;
  };

  boot.initrd.kernelModules = [ "vboxdrv" "vboxnetadp" "vboxnetflt" ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "24.05";
}
