import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2
import QtQuick.Layouts 1.3
import "../modules/"

Item {
    id: root
    width: parent.width
    height: parent.height
    visible: true

    Rectangle {
        id: background_colour
        visible: true
        anchors.fill: parent
        color: "#151515"

        Speed {
            id: speed_indicator
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            y: 67 * root.height/800
        }

        LaptimeLast {
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            z: 1
            y: 120 * root.height/800
            color: "transparent"
        }
        LaunchControlSymbol {
            x: 185 * root.width/480
            y: 520 * root.height/800
        }

        LaptimeDelta {
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width
            y: 220 * root.height/600
        }

        InfoBar {
            x: 0 * root.width/480
            y: 680 * root.height/800
        }
    }
}
