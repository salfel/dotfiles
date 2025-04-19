{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      gtk-titlebar = false;

      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;

      adjust-underline-position = 6;
      adjust-underline-thickness = 1;
      adjust-cell-height = "40%";

      window-padding-x = 12;
      window-padding-y = 12;

      confirm-close-surface = false;
    };
  };
}
