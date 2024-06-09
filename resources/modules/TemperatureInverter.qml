import QtQuick 2.0

Rectangle {
    id: temperature_digital
    property real floatTemp: sensors.temperatureInverter.toFixed(0)
    property bool isRed: false
    width: root.width/3
    height: 100 * root.height/800
    color: if (floatTemp > 70) {
               "red"
          } else if (floatTemp >= 0 || floatTemp <=  70) {
              "transparent"
          }
    border {
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        y: 8
        text: if (floatTemp >= 100 || floatTemp < 0) {
              } else {
                  ('10' + floatTemp).slice(-2) + "°C"
              }
        font.pixelSize: 80 * root.width/800
        font.bold: true
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 65 * root.height/800
        text: "INVERTER TEMP"
        font.pixelSize: 13 * root.width/400
        font.bold: true
        color: "white"
    }
}
