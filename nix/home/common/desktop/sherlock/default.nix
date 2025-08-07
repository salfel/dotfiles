{
  programs.sherlock = {
    enable = true;

    settings = {
      default_apps = {
        terminal = "ghostty";
      };

      appearance = {
        renderer = "cairo";

        width = 800;
        height = 600;

        icon_size = 16;
      };

      backdrop = {
        enable = true;
        opacity = 0.2;
      };
    };

    launchers = [
      {
        name = "Calculator";
        type = "calculation";
        args = ["calc.math" "calc.units"];
        priority = 1;
        on_return = "copy";
      }
      {
        name = "Emoji picker";
        type = "emoji_picker";
        alias = "em";
        args = {default_skintone = "Simpsons";};
        priority = 2;
        home = "Search";
      }
      {
        name = "App launcher";
        alias = "app";
        type = "app_launcher";
        args = [];
        priority = 3;
        home = "Home";
      }
    ];
  };
}
