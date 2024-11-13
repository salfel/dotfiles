{ config, pkgs, ... }: 
{
  programs.git = {
    enable = true;

    userEmail = "dev.felix.salcher@gmail.com";
    userName = "Felix Salcher";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}
