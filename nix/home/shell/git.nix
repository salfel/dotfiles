{ pkgs, ... }: {
  home.packages = with pkgs; [ git gh git-credential-manager ];

  programs.git = {
    enable = true;

    userEmail = "dev.felix.salcher@gmail.com";
    userName = "Felix Salcher";

    extraConfig = {
      credential = {
        helper = "manager";
        credentialStore = "secretservice";
      };
    };
  };
}
