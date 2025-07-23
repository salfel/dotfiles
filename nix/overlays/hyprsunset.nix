self: super: {
  hyprsunset = super.hyprsunset.overrideAttrs (oldAttrs: {
    version = "0.3.0";
    src = super.fetchFromGitHub {
      owner = "hyprwm";
      repo = "hyprsunset";
      tag = "v0.3.0";
      hash = "sha256-Cp5kHNfWFFyJpA5eRxZh/7fJcHU1uM2tBehQyeyKEUA=";
    };
    buildInputs = with super; [
      hyprland-protocols
      hyprutils
      hyprlang
      wayland
      wayland-protocols
      wayland-scanner
    ];
  });
}
