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

        Rectangle {
            id: central_box
            color: "transparent"
            z: 3
            x: 186 * root.width/800
            y: 78 * root.height/480
            width: 405 * root.width/800
            height: 402 * root.height/480
            border.color: "White"
            border.width: 1
        }
        RPM_wrapper {
            id: rpm_wrapper
            visible: true
            x: 400 * root.width/800
        }

        Speed {
            id: speed_indicator
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            y: 90 * root.height/480
        }

        Rectangle {
            id: soc_box
            color: "transparent"
            z: 3
            x: 0
            y: 78 * root.height/480
            width: 186 * root.width/800
            height: 402 * root.height/480
            border.color: "White"
            border.width: 1
        }
        SoC {
           x: 18 * root.width/800
           y: 435 * root.height/480
        }
        Text {
            id: battery_text
            x: 50 * root.width/800
            y: 448 * root.height/480
            color: "#cbcbcb"
            text: "BATTERY"
            font.pixelSize: 20/480 * root.height
            textFormat: Text.RichText
            font.family: "Roboto"
        }
        Laptime_delta {
            anchors {
                horizontalCenter: central_box.horizontalCenter
            }
            y: 260 * root.height/480

        }

        Laptime_last {
            anchors {
                horizontalCenter: central_box.horizontalCenter
            }
            z: 1
            y: 120 * root.height/480
            color: "transparent"
        }

        Power_regen_symbols {
            x: 590 * root.width/800
            y: 78 * root.height/480
        }

        Launch_control_symbol {
            anchors {
                horizontalCenter: central_box.horizontalCenter
                horizontalCenterOffset: -20 * root.width/800
            }
            y: 350 * root.height/480
        }
        Temperature_digital {
            x: 590 * root.width/800
            y: 137 * root.height/480
        }
        Tyre_indicators {
            x: 590 * root.width/800
            y: 271 * root.height/480
        }
        Temperature_warning {
            z:150;
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.verticalCenter: parent.verticalCenter;

        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.66;height:480;width:800}
}
##^##*/
