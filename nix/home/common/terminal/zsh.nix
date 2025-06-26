{config, ...}: {
  catppuccin.zsh-syntax-highlighting.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;

    shellAliases = {ls = "ls -la --color=auto";};

    initContent = ''
      export OPENAI_API_KEY=$(cat ${config.sops.secrets."openai_secret_key".path})

      # set cursor style
      echo -ne '\e[5 q'
    '';
  };
}
