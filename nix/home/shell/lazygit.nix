{
  catppuccin.lazygit = { enable = true; };

  programs.lazygit = {
    enable = true;

    settings = { gui = { skipDiscardChangeWarning = true; }; };
  };
}
