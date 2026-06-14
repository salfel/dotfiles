import Quickshell
import Quickshell.Io
import QtQuick

Item {
    id: root
    width: displayRow.implicitWidth
    height: displayRow.implicitHeight

    property var barWindow
    property bool calendarOpen: false

    // ── Clock Logic ──
    property string timeStr: ""
    property string dateStr: ""

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            var d = new Date();
            root.timeStr = Qt.formatTime(d, "h:mm AP");
            root.dateStr = Qt.formatDate(d, "dddd, MMMM d");
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    // ── Calendar Logic ──
    property string calText: ""

    Process {
        id: calProc
        command: ["cal"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.calText = this.text
        }
    }
    Timer {
        interval: 3600000
        running: true
        repeat: true
        onTriggered: calProc.running = true
    }

    Timer {
        id: calendarCloseTimer
        interval: 200
        onTriggered: calendarOpen = false
    }

    // ── UI ──
    Theme {
        id: theme
    }

    Row {
        id: displayRow
        spacing: 12

        Text {
            text: Qt.formatDateTime(clock.date, "hh:mm")
            color: theme.cSubtext0
            font.pointSize: theme.fontSizeLarge
            font.family: theme.fontFamily
            font.bold: true
        }
    }

    MouseArea {
        anchors.fill: displayRow
        hoverEnabled: true
        onEntered: {
            calendarCloseTimer.stop();
            calendarOpen = true;
        }
        onExited: {
            calendarCloseTimer.start();
        }
    }

    PopupWindow {
        id: calendarPopup
        anchor.window: root.barWindow
        anchor.rect.x: root.barWindow.width / 2 - implicitWidth / 2
        anchor.rect.y: root.barWindow.height
        implicitWidth: 250
        implicitHeight: 230
        visible: calendarOpen
        color: theme.cCrust

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: calendarCloseTimer.stop()
            onExited: calendarCloseTimer.start()
        }

        Column {
            anchors.centerIn: parent
            spacing: 12
            Text {
                text: root.dateStr
                color: theme.cLavender
                font.family: theme.fontFamily
                font.bold: true
                font.pointSize: theme.fontSizeLarge
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                text: root.calText
                color: theme.cText
                font.family: theme.fontFamily
                font.pointSize: theme.fontSizeLarge
                lineHeight: 1.2
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
