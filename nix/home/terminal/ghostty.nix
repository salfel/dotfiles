{
  home.file.".config/ghostty/shaders/cursor_smear.glsl".source = ./shaders/cursor_smear.glsl;

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Catppuccin Mocha";

      background-opacity = 0.9;

      font-family = "MonaspiceKr Nerd Font";
      font-size = 13;

      adjust-underline-position = 6;
      adjust-underline-thickness = 1;
      adjust-cell-height = "40%";

      window-padding-x = 12;
      window-padding-y = 12;

      confirm-close-surface = false;

      custom-shader = "shaders/cursor_smear.glsl";
    };
  };
}
