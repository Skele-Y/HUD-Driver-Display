import QtQuick 2.12

Item {
    id: tractioncontrol
    width: lc
    transformOrigin: width/2
    property real imgWidth: root.width*0.3/480
    property real imgHeight: root.height*0.3/800
    property real tcActive: sensors.tcMode.toFixed(0)

    Image {
        source: if (tcActive == 1) {
                    "qrc:/resources/images/tc_on.png"
                } else {
                    "qrc:/resources/images/tc_off.png"
                }
        fillMode: Image.PreserveAspectFit
        transform: Scale { xScale: 1.5*imgWidth; yScale: 1.5*imgHeight}
        smooth: false
        x: 0
        y: 0
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
