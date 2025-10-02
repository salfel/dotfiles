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
        alt_a (multi-tap 200 (tap-hold-next-release 200 a lalt) a)
        met_s (multi-tap 200 (tap-hold-next-release 200 s lmet) s)
        sft_d (multi-tap 200 (tap-hold-next-release 200 d lsft) d)
        ctl_f (multi-tap 200 (tap-hold-next-release 200 f lctl) f)

        ctl_j (multi-tap 200 (tap-hold-next-release 200 j rctl) j)
        sft_k (multi-tap 200 (tap-hold-next-release 200 k rsft) k)
        met_l (multi-tap 200 (tap-hold-next-release 200 l rmet) l)
        alt_; (multi-tap 200 (tap-hold-next-release 200 ; lalt) ;)
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
