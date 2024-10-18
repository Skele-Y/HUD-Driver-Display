import QtQuick 2.0

Rectangle {
    id: temperature_digital
    property real floatTemp: sensors.temperatureSoC.toFixed(0)
    property bool isRed: false
    width: 140
    height: 67 * root.height/600
    color: if (floatTemp > 53) {
               "red"
            } else if (floatTemp >= 40 || floatTemp <= 53) {
                "orange"
            } else if (floatTemp >= 0 || floatTemp < 40) {
              "transparent"
          }
    border {
        color: "white"
        width: 3
    }
    radius: 3

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: if (floatTemp >= 100 || floatTemp < 0) {
              } else {
                  ('10' + floatTemp).slice(-2) + "°C"
              }

        font.pixelSize: 40 * root.width/1024
        font.bold: true
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: (120-84) * root.height/600
        text: "Accu."
        font.pixelSize: 20 * root.width/1024
        font.bold: true
        color: "white"
    }
}
