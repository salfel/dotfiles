{
  pkgs,
  config,
  ...
}: let
  ignorePath = "${config.home.homeDirectory}/.gitignore";
  ignoreFiles = ''
    .ccls-cache
  '';
in {
  home.file."${ignorePath}".text = ignoreFiles;
  home.packages = with pkgs; [git gh git-credential-manager];

  programs.git = {
    enable = true;

    extraConfig = {
      core.excludesFile = ignorePath;

      push.autoSetupRemote = true;
    };
  };
}
