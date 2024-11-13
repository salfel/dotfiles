{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      catppuccin.enable = true; 
    };
    
    oh-my-zsh = {
      enable = true;
    };
  
    initExtra = ''
      eval "$(starship init zsh)"
    '';
  };
}
