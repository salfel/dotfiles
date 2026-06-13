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
        command: ["bash", "-c", "setxkbmap -query 2>/dev/null | grep layout | awk '{print $2}' || echo 'N/A'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.kbLayout = this.text.trim()
        }
    }
    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: kbProc.running = true
    }

    // ── UI ──
    Theme {
        id: theme
    }

    Text {
        text: "⌨"
        color: theme.cText
        font.pointSize: 9
    }
    Text {
        text: root.kbLayout.toUpperCase()
        color: theme.cText
        font.pointSize: 9
    }
}
