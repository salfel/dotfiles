let
  githubToken = "/home/felix/.ssh/github_token";
in {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        serverAliveInterval = 60;
        compression = true;
      };

      "github.com" = {
        identityFile = githubToken;
        user = "git";
      };
    };
  };
}
