{pkgs, ...}: let
  keyboards = [
    "/dev/input/event13"
  ];

  mk-keyboard = keyboard-name: {
    name = builtins.baseNameOf keyboard-name;
    value = {
      device = keyboard-name;
      config = ''
        (defcfg
          input (device-file "${keyboard-name}")
          output (uinput-sink "Integrated Keyboard")
          fallthrough true
        )

        (defsrc
          capslock esc    a    s    d    f    g    h    j    k    l    ;
        )

        (defalias
          alt_a (multi-tap 150 (tap-hold-next-release 150 a lalt) a)
          met_s (multi-tap 150 (tap-hold-next-release 150 s lmet) s)
          sft_d (multi-tap 150 (tap-hold-next-release 150 d lsft) d)
          ctl_f (multi-tap 150 (tap-hold-next-release 150 f lctl) f)

          ctl_j (multi-tap 150 (tap-hold-next-release 150 j rctl) j)
          sft_k (multi-tap 150 (tap-hold-next-release 150 k rsft) k)
          met_l (multi-tap 150 (tap-hold-next-release 150 l rmet) l)
          alt_; (multi-tap 150 (tap-hold-next-release 150 ; lalt) ;)
        )

        (deflayer homerowmods
          capslock esc @alt_a @met_s @sft_d @ctl_f g h @ctl_j @sft_k @met_l @alt_;
        )
      '';
    };
  };
in {
  environment.systemPackages = with pkgs; [kmonad];

  services.kmonad = {
    enable = true;
    keyboards = builtins.listToAttrs (map mk-keyboard keyboards);
  };
}
