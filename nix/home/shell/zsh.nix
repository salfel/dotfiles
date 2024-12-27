{
  catppuccin.zsh-syntax-highlighting.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting = { enable = true; };

    oh-my-zsh = { enable = true; };

    shellAliases = {
      mux = "tmuxinator start";
      ls = "ls -la --color=auto";
    };

    initExtra = ''
      # set cursor style
      echo -ne '\e[5 q'

      eval "$(starship init zsh)"
    '';
  };
}
