import QtQuick 2.0

Rectangle {
    id: temperature_digital
    property real torque: sensors.torqueSetting.toFixed(0)
    width: root.width/3
    height: 100 * root.height/800
    color: "transparent"
    border {
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        y: 8
        text: if (torque == 0) {
                  "LOW"
              } else if (torque == 1) {
                  "MED"
              } else if (torque == 2){
                  "HIGH"
              }
        font.pixelSize: 80 * root.width/800
        font.bold: true
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 65 * root.height/800
        text: "TORQUE MODE"
        font.pixelSize: 13 * root.width/400
        font.bold: true
        color: "white"
    }
}
