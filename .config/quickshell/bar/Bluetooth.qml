import Quickshell
import Quickshell.Bluetooth
import QtQuick

Row {
    id: root
    spacing: 6

    property var barWindow
    property bool popupOpen: false

    property bool iconHovered: false
    property bool popupHovered: false

    function scheduleCloseIfNeeded() {
        if (!iconHovered && !popupHovered && popupOpen)
            closeTimer.start();
    }

    function cancelClose() {
        closeTimer.stop();
    }

    onPopupOpenChanged: {
        if (popupOpen) {
            if (adapter)
                adapter.discovering = true;
        } else {
            closeTimer.stop();
            if (adapter)
                adapter.discovering = false;
        }
    }

    // ── Logic ──
    property BluetoothAdapter adapter: Bluetooth.defaultAdapter

    property bool anyConnected: {
        if (!adapter)
            return false;
        var devices = adapter.devices.values;
        for (var i = 0; i < devices.length; ++i) {
            if (devices[i].connected)
                return true;
        }
        return false;
    }

    property string btStatus: {
        if (!adapter || !adapter.enabled)
            return "Off";
        if (anyConnected)
            return "Connected";
        return "On";
    }

    function toggleDeviceConnection(device) {
        if (device.connected) {
            device.disconnect();
        } else {
            device.connect();
        }
    }

    Timer {
        id: closeTimer
        interval: 200
        repeat: false
        onTriggered: {
            if (!root.iconHovered && !root.popupHovered)
                popupOpen = false;
        }
    }

    // ── UI ──
    Theme {
        id: theme
    }

    Text {
        id: btText
        text: "\uF294 "
        color: {
            if (!adapter || !adapter.enabled)
                return theme.cOverlay0;
            if (anyConnected)
                return theme.cBlue;
            return theme.cText;
        }
        font.pointSize: theme.fontSize
        font.family: theme.fontFamily

        MouseArea {
            id: iconMouseArea
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                iconHovered = true;
                cancelClose();
            }

            onExited: {
                iconHovered = false;
                scheduleCloseIfNeeded();
            }

            onClicked: {
                popupOpen = !popupOpen;

                if (popupOpen) {
                    root.cancelClose();
                }
            }
        }
    }

    PopupWindow {
        id: btPopup
        anchor.window: root.barWindow
        anchor.rect.x: root.barWindow ? Math.max(0, root.parent.x + btText.x + btText.width / 2 - implicitWidth / 2) : 0
        anchor.rect.y: root.barWindow ? root.barWindow.height : 0
        implicitWidth: 260
        implicitHeight: 320
        visible: popupOpen
        color: "transparent"

        Item {
            anchors.fill: parent

            HoverHandler {
                onHoveredChanged: {
                    root.popupHovered = hovered;
                    if (hovered)
                        cancelClose();
                    else
                        scheduleCloseIfNeeded();
                }
            }

            Rectangle {
                anchors.fill: parent
                color: theme.cCrust
                radius: 8

                transform: Translate {
                    y: popupOpen ? 0 : -parent.height

                    Behavior on y {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                Flickable {
                    anchors.fill: parent
                    anchors.margins: 12
                    contentHeight: popupColumn.implicitHeight
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds

                    Column {
                        id: popupColumn
                        width: parent.width
                        spacing: 8

                        Row {
                            width: parent.width
                            spacing: 8

                            Text {
                                text: "Bluetooth"
                                color: theme.cLavender
                                font.family: theme.fontFamily
                                font.bold: true
                                font.pointSize: theme.fontSizeLarge
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Item {
                                width: parent.width - parent.children[0].implicitWidth - parent.children[2].implicitWidth - 16
                                height: 1
                            }

                            Text {
                                text: adapter && adapter.enabled ? "On" : "Off"
                                color: adapter && adapter.enabled ? theme.cGreen : theme.cOverlay0
                                font.pointSize: theme.fontSize
                                font.family: theme.fontFamily
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: 28
                            color: toggleMouseArea.containsMouse ? theme.cSurface1 : theme.cSurface0
                            radius: 4
                            visible: adapter !== null

                            Text {
                                anchors.centerIn: parent
                                text: adapter && adapter.enabled ? "Disable" : "Enable"
                                color: theme.cText
                                font.pointSize: theme.fontSize
                                font.family: theme.fontFamily
                            }

                            MouseArea {
                                id: toggleMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    if (adapter)
                                        adapter.enabled = !adapter.enabled;
                                }
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: 28
                            color: scanMouseArea.containsMouse ? theme.cSurface1 : theme.cSurface0
                            radius: 4
                            visible: adapter !== null && adapter.enabled

                            Text {
                                anchors.centerIn: parent
                                text: adapter && adapter.discovering ? "Stop Scanning" : "Scan for Devices"
                                color: theme.cText
                                font.pointSize: theme.fontSize
                                font.family: theme.fontFamily
                            }

                            MouseArea {
                                id: scanMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    if (adapter)
                                        adapter.discovering = !adapter.discovering;
                                }
                            }
                        }

                        Text {
                            text: "No devices"
                            color: theme.cOverlay0
                            font.pointSize: theme.fontSize
                            font.family: theme.fontFamily
                            visible: !adapter || !adapter.devices.values || adapter.devices.values.length === 0
                        }

                        Repeater {
                            model: adapter ? adapter.devices.values : null

                            delegate: Rectangle {
                                width: parent.width
                                height: 28
                                color: deviceMouseArea.containsMouse ? theme.cSurface1 : (modelData.connected ? theme.cSurface0 : "transparent")
                                radius: 4

                                Row {
                                    anchors.fill: parent
                                    anchors.leftMargin: 6
                                    anchors.rightMargin: 6
                                    spacing: 8

                                    Text {
                                        text: modelData.name || modelData.deviceName || modelData.address
                                        color: theme.cText
                                        font.pointSize: theme.fontSize
                                        font.family: theme.fontFamily
                                        anchors.verticalCenter: parent.verticalCenter
                                        elide: Text.ElideRight
                                        width: parent.width - 60
                                    }

                                    Text {
                                        text: modelData.connected ? "\u25CF" : (modelData.paired ? "\u25CB" : "")
                                        color: modelData.connected ? theme.cGreen : theme.cOverlay0
                                        font.pointSize: theme.fontSize
                                        font.family: theme.fontFamily
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    Text {
                                        text: modelData.batteryAvailable ? Math.round(modelData.battery * 100) + "%" : ""
                                        color: theme.cOverlay1
                                        font.pointSize: theme.fontSize
                                        font.family: theme.fontFamily
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                MouseArea {
                                    id: deviceMouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: toggleDeviceConnection(modelData)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
