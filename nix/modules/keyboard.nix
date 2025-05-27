{pkgs, ...}: let
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
        alt_a (tap-hold-next-release 200 a lalt)
        met_s (tap-hold-next-release 200 s lmet)
        sft_d (tap-hold-next-release 200 d lsft)
        ctl_f (tap-hold-next-release 200 f lctl)

        ctl_j (tap-hold-next-release 200 j rctl)
        sft_k (tap-hold-next-release 200 k rsft)
        met_l (tap-hold-next-release 200 l rmet)
        alt_; (tap-hold-next-release 200 ; lalt)
    )

    (deflayer homerowmods
        esc capslock @alt_a   @met_s   @sft_d   @ctl_f   g   h   @ctl_j   @sft_k   @met_l   @alt_;
    )

  '';
in {
  environment.systemPackages = with pkgs; [kmonad];

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
