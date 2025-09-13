let
  githubToken = "/home/felix/.ssh/github_token";
in {
  programs.ssh = {
    enable = true;

    extraConfig = ''
      Host github.com
        IdentityFile ${githubToken}
        User git
    '';
  };
}
