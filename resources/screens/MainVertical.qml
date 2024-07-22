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

        StateOfCharge {
           x: 440 * root.width/480
           y: 0 * root.height/800
        }
        LaptimeLast {
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            z: 1
            y: 80 * root.height/800
            color: "transparent"
        }

        LaptimeDelta {
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width
            y: 180 * root.height/600

        }

        PowerRegenSymbols {
            anchors {
                horizontalCenter: parent.horizontalCenter
                horizontalCenterOffset: -20 * root.width/480
            }
            x: 178 * root.width/1024
            y: 692 * root.height/600
        }

        LaunchControlSymbol {
            x: 63 * root.width/480
            y: 410 * root.height/800
        }

        CruiseControlSymbol {
            x: 45 * root.width/480
            y: 490 * root.height/800
        }

        TyreIndicators {
            x: 205 * root.width/480
            y: 400 * root.height/800
        }
        WarningSoCTemp {
            z:150;
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.verticalCenter: parent.verticalCenter;
        }
        InfoBar {
            x: 0 * root.width/480
            y: 690 * root.height/800
        }
    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.66;height:480;width:800}
}
##^##*/
