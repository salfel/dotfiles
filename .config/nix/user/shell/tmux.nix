{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    mouse = true;
    prefix = "C-Space";
    baseIndex = 1;

    keyMode = "vi";
    
    catppuccin = {
      enable = true;
      flavor = "mocha";

      extraConfig = ''
        set -g @catppuccin_status_module_bg_color "none"
      '';
    };

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set-option -ga terminal-features ",kitty:usstyle"

      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind "'" split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      set -g update-environment "DISPLAY WAYLAND_DISPLAY XDG_RUNTIME_DIR HYPRLAND_INSTANCE_SIGNATURE"
    '';
  };

  home.sessionVariables = {
    XTERM = "xterm-256color";
  };
}
