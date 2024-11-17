{ config, pkgs, lib, ... }: 
{
  programs.starship = {
    enable = true;
  
    settings = {
      format = lib.concatStrings [
        "[](surface0)"
        "$os"
        "[](bg:peach fg:surface0)"
        "$directory"
        "[](fg:peach bg:green)"
        "$git_branch"
        "$git_status"
        "[](fg:green bg:blue)"
        "$cmd_duration"
        "[](fg:blue bg:purple)"
        "$time"
        "[ ](fg:purple)"
        "$line_break$character"
      ];
  
      palette = "catppuccin_mocha";
  
      palettes = {
        catppuccin_mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          orange = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };
      };
  
      os = {
        disabled = false;
        style = "bg:surface0 fg:text";
  
        symbols = {
          Ubuntu = "󰕈 ";
          SUSE = " ";
          Raspbian = "󰐿 ";
          Mint = "󰣭 ";
          Macos = " ";
          Manjaro = " ";
          Linux = "󰌽 ";
          Gentoo = "󰣨 ";
          Fedora = "󰣛 ";
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          Arch = "󰣇 ";
          Artix = "󰣇 ";
          CentOS = " ";
          Debian = "󰣚 ";
          Redhat = "󱄛 ";
          RedHatEnterprise = "󱄛 ";
          NixOS = " ";
        };
      };
  
      username = {
        show_always = true;
        style_user = "bg:surface0 fg:text";
        style_root = "bg:surface0 fg:text";
        format = "[ $user ]($style)";
      };
  
      directory = {
        style = "fg:mantle bg:peach";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "../";
      };
  
      git_branch = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol $branch ](fg:base bg:green)]($style)";
      };
  
      git_status = {
        style = "bg:blue";
        format = "[[($all_status$ahead_behind )](fg:base bg:green)]($style)";
      };
  
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:peach";
        format = "[[  $time ](fg:mantle bg:purple)]($style)";
      };
  
      cmd_duration = {
        min_time = 1000;
        format = "[ took $duration ](fg:base bg:blue)";
      };
  
      line_break.disabled = false;
  
      character = {
        success_symbol = "[❯](bold fg:green)";
        error_symbol = "[❯](bold fg:red)";
      };
    };
  };
}
