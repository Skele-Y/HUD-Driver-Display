import QtQuick 2.0

Rectangle {
    id: temperature_digital
    property real amps: sensors.dcl.toFixed(0)
    width: root.width/3
    height: 100 * root.height/800
    color: "transparent"
    border {
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 60 * root.height/800
        text: "DISCHARGE"
        font.pixelSize: 13 * root.width/400
        font.bold: true
        color: "white"
    }
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 75 * root.height/800
        text: "CURRENT LIMIT"
        font.pixelSize: 13 * root.width/400
        font.bold: true
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 8
        text: amps + "A"
        font.pixelSize: 80 * root.width/800
        font.bold: true
        color: "white"
    }
}
