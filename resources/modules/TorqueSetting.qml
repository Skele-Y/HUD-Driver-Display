import QtQuick 2.0

Rectangle {
    id: temperature_digital
    property real torque: sensors.torqueSetting.toFixed(0)
    width: 140 * root.width/1024
    height: 72 * root.height/600
    color: "transparent"
    radius: 3
    border {
        color: "white"
        width: 3
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
        font.pixelSize: 40 * root.width/1024
        font.bold: true
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 60 * root.height/800
        text: "Torque Md."
        font.pixelSize: 20 * root.width/1024
        font.bold: true
        color: "white"
    }
}
