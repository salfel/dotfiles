import Quickshell
import QtQuick

Scope {
    id: root

    Theme {
        id: theme
    }

    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                id: barWindow
                required property var modelData
                screen: modelData
                property string screenName: modelData.name

                anchors {
                    top: true
                    left: true
                    right: true
                }

                implicitHeight: 32
                color: theme.cBase

                Workspaces {
                    id: leftSection
                    anchors {
                        left: parent.left
                        leftMargin: 12
                        verticalCenter: parent.verticalCenter
                    }
                    screenName: barWindow.screenName
                }

                DateTime {
                    id: centerSection
                    anchors.centerIn: parent
                    barWindow: barWindow
                }

                Row {
                    id: rightSection
                    anchors {
                        right: parent.right
                        rightMargin: 12
                        verticalCenter: parent.verticalCenter
                    }
                    spacing: 16

                    Network {
                        id: network
                        barWindow: barWindow
                    }
                    Bluetooth {
                        id: bluetooth
                        barWindow: barWindow
                    }
                    Keyboard {
                        id: keyboard
                    }
                    Battery {
                        id: battery
                    }
                }
            }
        }
    }
}
