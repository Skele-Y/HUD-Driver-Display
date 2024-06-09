import QtQuick 2.0

Rectangle {
    id: temperature_digital
    property real Voltage: sensors.temperatureSoc.toFixed(0)
    width: 120*root.width/480
    height: 100 * root.height/800
    color: "transparent"
    border {
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        y: 8
        text: hi
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 65 * root.height/800
        text: "DCL VOLTAGE"
        font.pixelSize: 13 * root.width/400
        font.bold: true
        color: "white"
    }
}
