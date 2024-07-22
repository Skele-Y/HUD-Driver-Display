import QtQuick 2.12

Item {
    property real powermodefloat: sensors.powerMode.toFixed(0)
    property real regenmodefloat: sensors.regenMode.toFixed(0)
    Rectangle {
        width: 210 * root.width/1024
        height: 60 * root.height/600
        color: "Transparent"
        border.color: "White"
        border.width: 1
    }

    Text {
        id: pmodetext
        x: 5 * root.width/1024
        y: 6 * root.height/600
        color: "#FFFFFF"
        font.pixelSize: 12 * (root.height / 480)
        font.styleName: "Bold"
        font.family: "Roboto"
        text: "POWER MODE"
    }
    Text {
        id: rmodetext
        x: 110 * root.width / 800
        y: 6 * root.height/600
        color: "#FFFFFF"
        font.pixelSize: 12 * (root.height / 480)
        font.styleName: "Bold"
        font.family: "Roboto"
        text: "REGEN MODE"
    }
    Text {
        anchors.horizontalCenter: pmodetext.horizontalCenter
        y: 31 * root.height/800
        color: "#FFFFFF"
        font.pixelSize: 26 * (root.height / 480)
        font.styleName: "Normal"
        font.family: "Roboto"
        text: if (powermodefloat < 4 && powermodefloat >= 0) {
                  powermodefloat
            }
    }
    Text {
        anchors.horizontalCenter: rmodetext.horizontalCenter
        y: 31 * root.height/800
        color: "#FFFFFF"
        font.pixelSize: 26 * (root.height / 480)
        font.styleName: "Normal"
        font.family: "Roboto"
        text: if (regenmodefloat < 4 && regenmodefloat >= 0) {
                  regenmodefloat
              }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:41;width:226}
}
##^##*/
