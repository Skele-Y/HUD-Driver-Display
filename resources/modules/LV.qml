import QtQuick 2.0

Rectangle {
    id: temperature_digital
    property real voltage: sensors.lowVoltage.toFixed(1)
    width: 150*root.width/480
    height: 100 * root.height/800
    color: "transparent"
    border {
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        y: 6*root.width/1024
        text: voltage + "V"
        font.pixelSize: 75 * root.width/1024
        font.bold: true
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 65 * root.height/800
        text: "LV BATTERY"
        font.pixelSize: 13 * root.width/400
        font.bold: true
        color: "white"
    }
}
