{
  pkgs,
  inputs,
  customPkgs,
  ...
}: {
  imports = [./modules];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };
  catppuccin.grub = {
    enable = true;
    flavor = "mocha";
  };

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

  # Fingerprint reader
  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "net.reactivated.fprint.device.enroll" ||
           action.id == "net.reactivated.fprint.device.verify" ||
           action.id == "net.reactivated.fprint.device.identify") &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
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
      extraGroups = ["networkmanager" "wheel" "input"];
      initialPassword = "password";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Desktop Utilities
    waybar
    rofi
    hyprpaper
    hypridle
    hyprlock
    hyprcursor
    hyprsunset
    hyprshot
    wl-clipboard
    pulseaudio
    brightnessctl
    playerctl
    swaynotificationcenter
    libnotify
    swayosd
    pwvucontrol
    networkmanagerapplet

    # Terminal utilities
    tmux
    neovim
    tree-sitter
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
    socat
    inputs.sessionizer.packages.${pkgs.stdenv.hostPlatform.system}.default
    lutgen
    # customPkgs.odin-bindgen

    # Browsers
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    brave

    # Productivity
    libreoffice
    obsidian
    drawio
    gimp

    # Latex
    pgf
    texliveMedium
    zathura

    # Dev Apps
    vscode
    postman
    qemu
    renderdoc
    opencode
    filezilla

    # Games
    steam
    lunar-client
    discord

    # Misc
    obs-studio
    keymapp

    # wine
    wineWow64Packages.stable
    wineWow64Packages.wayland
    winetricks
  ];

  hardware.keyboard.zsa.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.monaspace
    lato
    roboto
    montserrat
    open-sans
    oswald
    customPkgs.font
  ];

  services.actual = {
    enable = true;
    settings = {
    };
  };

  programs.hyprland.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "25.05";
}
