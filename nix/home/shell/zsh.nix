{
  catppuccin.zsh-syntax-highlighting.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting = { enable = true; };

    oh-my-zsh = { enable = true; };

    shellAliases = { ls = "ls -la --color=auto"; };

    initContent = ''
      # set cursor style
      echo -ne '\e[5 q'
    '';
  };
}
