{
  pkgs,
  lib,
  inputs,
  customPkgs,
  ...
}: {
  imports = [./modules ./overlays];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "salfel";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.polkit.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,de";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        AutoConnect = true;
        Experimental = true;
      };
    };
  };

  services.blueman.enable = true;

  # shells
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  users.users = {
    felix = {
      isNormalUser = true;
      description = "Felix Salcher";
      extraGroups = ["networkmanager" "wheel" "docker"];
      initialPassword = "password";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Desktop Utilities
    waybar
    rofi
    hyprshot
    hyprpaper
    hypridle
    hyprlock
    hyprcursor
    hyprsunset
    wl-clipboard
    pulseaudio
    brightnessctl
    playerctl
    swaynotificationcenter
    libnotify
    swayosd

    # Terminal utilities
    tmux
    neovim
    ghostty
    fastfetch
    stow
    unzip
    fzf
    ripgrep
    cloc
    tree
    silicon
    jq
    xxd

    # Dev Apps
    vscode
    postman
    qemu

    sops
    age

    gimp
    keymapp

    pavucontrol
    networkmanagerapplet

    obs-studio

    inputs.sessionizer.packages.${system}.default

    lutgen
    claude-code
    renderdoc
  ];

  hardware.keyboard.zsa.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    lato
    roboto
    montserrat
    open-sans
    oswald
    customPkgs.font
  ];

  # 1password
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) ["1password-gui" "1password"];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["felix"];
  };

  programs.hyprland.enable = true;

  virtualisation = {
    docker.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "25.05";
}
