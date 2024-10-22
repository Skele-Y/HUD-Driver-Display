import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2
import QtQuick.Layouts 1.3
import "../modules/"

Item {
    id: root
    visible: true

    Rectangle {
        id: background_colour
        visible: true
        anchors.fill: parent
        color: "black"


        Rectangle {
            id: critical_area
            visible: true
            color: "transparent"
            border.width: 75
            border.color: "black"
            anchors.fill: parent
            Rectangle {
                x:73
                y:71
                height:297
                width:193
                color: "black"
            }
            Rectangle {
                x:73
                y:354
                height:182
                width:648
                color: "black"
            }
            Rectangle {
                x:721
                y:71
                height:458
                width:273
                color: "black"
            }

        }

        LaunchControlSymbol {
            x: 310 * root.width/1024
            y: 285 * root.height/600
        }

        CruiseControlSymbol {
            x: 640 * root.width/1024
            y: 270 * root.height/600
        }

        TemperatureAccuDigital {
            x: 275 * root.width/1024
            y: 84 * root.height/600
        }

        TorqueSetting {
            x: 575 * root.width/1024
            y: 84 * root.height/600
        }

        LaptimeDelta {
            x: 400
            y: 298 * root.height/600

        }
        LaptimeLast {
            z: 1
            y: 170 * root.height/600
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

        TestHUDs {
            width: 457
            height: 279
            x: 266 * root.width/1024
            y: 75 * root.height/600
            z:30
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.66;height:480;width:800}
}
##^##*/
