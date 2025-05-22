{ pkgs, ... }:
let
  keyboard = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
  kmonadCfg = ''
    (defcfg
        input (device-file "${keyboard}")
        output (uinput-sink "Integrated Keyboard")
        fallthrough true
    )

    (defsrc
        capslock esc

        ;; Home row modifiers
        a    s    d    f    g    h    j    k    l    ;
    )

    (defalias
        met_a (tap-hold-next-release 200 a lmet)
        alt_s (tap-hold-next-release 200 s lalt)
        sft_d (tap-hold-next-release 200 d lsft)
        ctl_f (tap-hold-next-release 200 f lctl)

        ctl_j (tap-hold-next-release 200 j rctl)
        sft_k (tap-hold-next-release 200 k rsft)
        alt_l (tap-hold-next-release 200 l lalt)
        met_; (tap-hold-next-release 200 ; rmet)
    )

    (deflayer homerowmods
        esc capslock @met_a   @alt_s   @sft_d   @ctl_f   g   h   @ctl_j   @sft_k   @alt_l   @met_;
    )

  '';
in {
  environment.systemPackages = with pkgs; [ kmonad ];

  services.kmonad = {
    enable = true;
    keyboards = {
      "integrated-keyboard" = {
        device = keyboard;
        config = kmonadCfg;
      };
    };
  };
}
