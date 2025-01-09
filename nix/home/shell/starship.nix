{ lib, ... }: {
  programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_status"
        "$git_metrics"
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

      directory = {
        style = "fg:rosewater bold italic";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "../";
      };

      git_branch = {
        symbol = "";
        format = "[[ $symbol $branch ](fg:blue)]($style)";
      };

      git_status = {
        format = "[[($all_status$ahead_behind )](fg:blue)]($style)";
      };

      git_metrics = {
        disabled = false;
        added_style = "italic green";
        deleted_style = "italic red";
      };

      line_break.disabled = false;

      character = {
        success_symbol = "[❯](bold fg:green)";
        error_symbol = "[❯](bold fg:red)";
      };
    };
  };
}
