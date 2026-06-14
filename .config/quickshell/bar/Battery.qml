import Quickshell
import Quickshell.Io
import QtQuick

Row {
    id: root
    spacing: 6

    // ── Logic ──
    property int batteryLevel: 0
    property int batteryMaxCap: 100
    property string batteryStatus: ""

    Process {
        id: batteryCap
        command: ["cat", "/sys/class/power_supply/BAT1/capacity"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.batteryLevel = parseInt(this.text.trim()) || 0
        }
    }
    Process {
        id: batteryStat
        command: ["cat", "/sys/class/power_supply/BAT1/status"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.batteryStatus = this.text.trim()
        }
    }
    Process {
        id: batteryMax
        command: ["cat", "/sys/class/power_supply/BAT1/charge_control_end_threshold"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.batteryMaxCap = parseInt(this.text.trim()) || 100
        }
    }
    Timer {
        interval: 30000
        running: true
        repeat: true
        onTriggered: {
            batteryCap.running = true;
            batteryStat.running = true;
            batteryMax.running = true;
        }
    }

    // ── UI ──
    Theme { id: theme }

    visible: root.batteryStatus !== ""

    Text {
        text: {
            var icons = [" ", " ", " ", " ", " "];
            var idx = Math.min(4, Math.floor((root.batteryLevel / root.batteryMaxCap) * 4));
            return icons[idx];
        }
        color: root.batteryLevel >= root.batteryMaxCap ? theme.cBlue : (root.batteryStatus === "Charging" ? theme.cGreen : (root.batteryLevel < 15 ? theme.cRed : (root.batteryLevel < 30 ? theme.cPeach : theme.cText)))
        font.pointSize: theme.fontSize
        font.family: theme.fontFamily
    }
    Text {
        text: root.batteryLevel + "%"
        color: root.batteryLevel >= root.batteryMaxCap ? theme.cBlue : (root.batteryStatus === "Charging" ? theme.cGreen : (root.batteryLevel < 15 ? theme.cRed : (root.batteryLevel < 30 ? theme.cPeach : theme.cText)))
        font.pointSize: theme.fontSize
        font.family: theme.fontFamily
    }
}
