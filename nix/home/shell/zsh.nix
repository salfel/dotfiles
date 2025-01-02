{
  catppuccin.zsh-syntax-highlighting.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting = { enable = true; };

    oh-my-zsh = { enable = true; };

    shellAliases = { ls = "ls -la --color=auto"; };

    initExtra = ''
      # set cursor style
      echo -ne '\e[5 q'

      eval "$(starship init zsh)"

      tmux attach > /dev/null 2>&1
    '';
  };
}
