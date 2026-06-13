import Quickshell
import Quickshell.Hyprland
import QtQuick

Row {
    id: root
    spacing: 8

    property string screenName: ""

    Theme {
        id: theme
    }

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            width: 8
            height: 8
            radius: 6
            color: theme.cBase

            Text {
                anchors.centerIn: parent
                text: modelData.id
                color: modelData.focused ? theme.cText : theme.cOverlay2
                font.bold: true
                font.pointSize: 9
            }
            //
            // MouseArea {
            //     anchors.fill: parent
            //     onClicked: Hyprland.dispatch(`hl.dsp.focus({workspace=${modelData.id})`)
            // }
        }
    }
}
