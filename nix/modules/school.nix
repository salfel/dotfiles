{ pkgs, ... }: { environment.systemPackages = with pkgs; [ scilab-bin ]; }
