{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      window_padding_width = 12;
      background_opacity = 0.9;
      background_blur = 32;
    };

    extraConfig = ''
      modify_font cell_height 140%
      modify_font underline_position 8px
      modify_font underline_thickness 200%
    '';

    catppuccin.enable = true;
  };
}
