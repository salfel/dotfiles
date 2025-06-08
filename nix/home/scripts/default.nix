{pkgs, ...}: let
  sessionizer-script =
    pkgs.writeScriptBin "sessionizer" (builtins.readFile ./sessionizer.sh);
in {home.packages = [sessionizer-script];}
