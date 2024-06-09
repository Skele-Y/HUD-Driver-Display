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
            y: 80 * root.height/800
            color: "transparent"
        }
        LongitudinalGsWithArrow{
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }
        InfoBar {
            x: 0 * root.width/480
            y: 690 * root.height/800
        }
    }
}
