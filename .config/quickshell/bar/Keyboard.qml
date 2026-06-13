import Quickshell
import Quickshell.Io
import QtQuick

Row {
    id: root
    spacing: 6

    // ── Logic ──
    property string kbLayout: "us"

    Process {
        id: kbProc
        command: ["bash", "-c", "hyprctl -j devices | jq '.keyboards[] | .name, .\"active_keymap\"'| tail -n1"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                var rawLayout = this.text.trim();
                if (rawLayout == "\"English (US)\"") {
                    kbLayout = "us";
                } else if (rawLayout == "\"German\"") {
                    kbLayout = "de";
                } else {
                    kbLayout = rawLayout;
                }
            }
        }
    }
    Timer {
        interval: 200
        running: true
        repeat: true
        onTriggered: kbProc.running = true
    }

    // ── UI ──
    Theme {
        id: theme
    }

    Text {
        text: ""
        color: theme.cText
        font.pointSize: 9
        font.family: theme.fontFamily
    }
    Text {
        text: root.kbLayout
        color: theme.cText
        font.pointSize: 9
        font.family: theme.fontFamily
    }
}
