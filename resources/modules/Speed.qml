import QtQuick 2.12

Item {
    id: speed_indicator
    height: speed_no.height
    width: speed_no.width + speed_kmh.width
    property real velocity: Math.round(sensors.carSpeed)

    Text {
        id: speed_no
        z: 3
        font.pixelSize: 64 * (root.height / 800)
        horizontalAlignment: Text.AlignRight
        font.family: "Arial"
        font.styleName: "Bold"
        color: "white"
        text: if (velocity < 0) {0}
                else {velocity}

        Text {
            id: speed_kmh
            font.pixelSize: 24 * (root.height / 800)
            font.family: "Arial"
            font.styleName: "Regular"
            anchors {
                left: parent.right
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 4
            }

            color: "white"
            text: " KM/H"
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:2;height:480;width:640}
}
##^##*/
