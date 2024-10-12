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
        color: "#000000"

        Speed {
            id: speed_indicator
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            y: 90 * root.height/600
        }


        LaptimeDelta {
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width
            y: 200 * root.height/600

        }
        LaptimeLast {
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            z: 1
            y: 450 * root.height/800
            color: "transparent"
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.66;height:480;width:800}
}
##^##*/
