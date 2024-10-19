{ config, pkgs, ... }: 
{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };

    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      window_padding_width = 12;
      background_opacity = 0.95;
    };

    extraConfig = ''
      modify_font cell_height 140%
    '';

    catppuccin.enable = true;
  };
}
