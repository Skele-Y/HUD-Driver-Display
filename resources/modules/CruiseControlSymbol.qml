import QtQuick 2.12

Item {
    id: cruisecontrol
    width: cc
    transformOrigin: width/2
    property real imgWidth: root.width*0.2/1024
    property real imgHeight: root.height*0.2/600
    property real ccActive: sensors.ccActive.toFixed(0)

    Image {
        id: cc
        source: if (ccActive == 1) {
                    "qrc:/resources/images/cruise_control_on.png"
                } else {
                    "qrc:/resources/images/cruise_control_off.png"
                }
        fillMode: Image.PreserveAspectFit
        transform: Scale { xScale: 2*imgWidth; yScale: 2*imgHeight}
        smooth: true
        x: 0
        y: 0
    }
}
