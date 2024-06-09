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
        source: if (lcActive == 1) {
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
        x: 100
        y: 25
        text: "LC ACTIVE"
        font.pixelSize: 26 * (root.height / 480)
        font.styleName: "Normal"
        font.weight: Font.Bold
        font.family: "Roboto"
        color: if (lcActive == 1){
                  "#FE0000"
               } else {
                  "#A50000"
               }
    }
}

