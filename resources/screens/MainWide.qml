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


        RPMWrapper {
            id: rpm_wrapper
            visible: true
            x: 400 * root.width/1024
        }

        Speed {
            id: speed_indicator
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            y: 90 * root.height/600
        }

//        StateOfCharge {
//           x: 18 * root.width/1024
//           y: 435 * root.height/600
//        }
        Text {
            id: battery_text
            x: 50 * root.width/1024
            y: 448 * root.height/600
            color: "#cbcbcb"
            text: "BATTERY"
            font.pixelSize: 20/480 * root.height
            textFormat: Text.RichText
            font.family: "Roboto"
        }
        LaptimeDelta {
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width
            y: 500 * root.height/600

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
