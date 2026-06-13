import Quickshell
import Quickshell.Networking
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
            if (wifiDevice)
                wifiDevice.scannerEnabled = true;
        } else {
            closeTimer.stop();
            if (wifiDevice)
                wifiDevice.scannerEnabled = false;
        }
    }

    // ── Logic ──
    property string netStatus: {
        var devices = Networking.devices.values;
        for (var i = 0; i < devices.length; ++i) {
            var device = devices[i];
            if (device.connected) {
                if (device.type === DeviceType.Wifi) {
                    var networks = device.networks.values;
                    for (var j = 0; j < networks.length; ++j) {
                        if (networks[j].connected)
                            return networks[j].name;
                    }
                } else if (device.type === DeviceType.Wired) {
                    return "Wired";
                }
            }
        }
        return "Disconnected";
    }

    property var wifiDevice: {
        var devices = Networking.devices.values;
        for (var i = 0; i < devices.length; ++i) {
            if (devices[i].type === DeviceType.Wifi)
                return devices[i];
        }
        return null;
    }

    function toggleConnection(network) {
        if (network.connected) {
            network.disconnect();
        } else {
            network.connect();
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
        id: netText
        text: "\uF1EB "
        color: theme.cText
        font.pointSize: 9
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
        id: networkPopup
        anchor.window: root.barWindow
        anchor.rect.x: root.barWindow ? Math.max(0, root.parent.x + netText.x + netText.width / 2 - implicitWidth / 2) : 0
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

                        Text {
                            text: "Wi-Fi"
                            color: theme.cLavender
                            font.family: theme.fontFamily
                            font.bold: true
                            font.pointSize: 10
                        }

                        Text {
                            text: "No networks found"
                            color: theme.cOverlay0
                            font.pointSize: 9
                            font.family: theme.fontFamily
                            visible: !wifiDevice || !wifiDevice.networks.values || wifiDevice.networks.values.length === 0
                        }

                        Repeater {
                            model: wifiDevice ? wifiDevice.networks.values : null

                            delegate: Rectangle {
                                width: parent.width
                                height: 28
                                color: mouseArea.containsMouse ? theme.cSurface1 : (modelData.connected ? theme.cSurface0 : "transparent")
                                radius: 4

                                Row {
                                    anchors.fill: parent
                                    anchors.leftMargin: 6
                                    anchors.rightMargin: 6
                                    spacing: 8

                                    Text {
                                        text: modelData.name
                                        color: theme.cText
                                        font.pointSize: 9
                                        font.family: theme.fontFamily
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    Text {
                                        text: modelData.security !== WifiSecurityType.Open ? "\uD83D\uDD12" : ""
                                        color: theme.cOverlay0
                                        font.pointSize: 8
                                        font.family: theme.fontFamily
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    Text {
                                        text: modelData.connected ? "\u25CF" : ""
                                        color: theme.cGreen
                                        font.pointSize: 7
                                        font.family: theme.fontFamily
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                MouseArea {
                                    id: mouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: toggleConnection(modelData)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
