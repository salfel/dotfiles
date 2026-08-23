{
  config,
  pkgs,
  ...
}: {
  catppuccin.zsh-syntax-highlighting.enable = true;

  home.packages = [pkgs.eza];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;

    shellAliases = {
      ls = "eza -la --color=auto";
      nd = "nix develop -c zsh";
      open = "xdg-open";
    };

    initContent = ''
      export OPENAI_API_KEY=$(cat ${config.sops.secrets."openai_secret_key".path})

      # set cursor style
      echo -ne '\e[5 q'
    '';
  };
}
