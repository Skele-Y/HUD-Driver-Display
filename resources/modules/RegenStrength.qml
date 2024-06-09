import QtQuick 2.12

Rectangle {
    width: root.width/3
    height: 100 * root.height/800
    color: "transparent"
    border {
        color: "white"
    }
    property real regenStrength: {
       if (sensors.regenStrength > 1)
           return 100
       else if (sensors.regenStrength < 0)
           return 0
       else return sensors.regenStrength.toFixed(3) * 100
    }

    Text {
        y: 60 * root.height/800
        anchors.horizontalCenter: parent.horizontalCenter
        text: "REGEN"
        font.pixelSize: 16 * root.width/480
        font.bold: true
        color: "white"
    }

    Text {
        y: 80 * root.height/800
        anchors.horizontalCenter: parent.horizontalCenter
        text: "STRENGTH"
        font.pixelSize: 16 * root.width/480
        font.bold: true
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        y: 0
        text: regenStrength + "%"

        font.pixelSize: 55 * root.width/480
        font.bold: true
        color: "white"
    }

    Image {

    }
}
