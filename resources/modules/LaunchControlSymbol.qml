import QtQuick 2.12

Item {
    id: launchcontrol
    width: lc
    transformOrigin: width/2
    property real imgWidth: root.width*0.3/480
    property real imgHeight: root.height*0.3/800
    property real lcActive: sensors.lcMode.toFixed(0)

    Image {
        id: lc
        source: if (lcActive == 2 || lcActive == 3) {
                    "qrc:/resources/images/launch_control_on.png"
                } else {
                    "qrc:/resources/images/launch_control_off.png"
                }
        fillMode: Image.PreserveAspectFit
        transform: Scale { xScale: 3*imgWidth; yScale: 3*imgHeight}
        smooth: false
        x: 0
        y: 0
    }

    Text {
        font.pixelSize: 20 * (root.height / 480)
        y: -25
        anchors.horizontalCenter: parent.horizontalCenter
        color: if (lcActive == 2 || lcActive == 3) {
                   "red"
               } else {
                   "darkred"
               }
        text: if (lcActive == 0) {
            "Failed"
        } else if (lcActive == 1) {
            "Inactive"
        } else if (lcActive == 2) {
            "Ready"
        } else if (lcActive == 3) {
            ""
        }

    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
