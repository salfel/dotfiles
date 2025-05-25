{pkgs, ...}: let
  sessionizer-script =
    pkgs.writeScriptBin "sessionizer" (builtins.readFile ./sessionizer.sh);
  networkmanager-script =
    pkgs.writeScriptBin "networkmanager"
    (builtins.readFile ./networkmanager.sh);
in {home.packages = [sessionizer-script networkmanager-script];}
