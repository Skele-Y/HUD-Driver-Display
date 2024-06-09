import QtQuick 2.0

Rectangle {
    id: temperature_digital
    property real hVlow: sensors.hVlow.toFixed(2)
    property real hVmed: sensors.hVmed.toFixed(2)
    property real hVhigh: sensors.hVhigh.toFixed(2)
    width: 150 * root.width/480
    height: 200 * root.height/800
    color: "transparent"
    border {
        color: "white"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 6 * root.height/800
        text: "HV Cells"
        font.pixelSize: 20 * root.width/400
        font.bold: true
        color: "white"
    }

    Text {
        x: 10
        y: 50 * root.height/800
        text: "MIN:"
        font.pixelSize: 15 * root.width/400
        font.bold: true
        color: "white"
    }

    Text {
        x: 70
        y: 35*root.height/800
        text: hVlow
        font.pixelSize: 30 * root.width/400
        font.bold: true
        color: "white"
    }
    Text {
        x: 10
        y: 100 * root.height/800
        text: "AVG:"
        font.pixelSize: 15 * root.width/400
        font.bold: true
        color: "white"
    }
    Text {
        x: 70
        y: 85 * root.height/800
        text: hVmed
        font.pixelSize: 30 * root.width/400
        font.bold: true
        color: "white"
    }
    Text {
        x: 10
        y: 150 * root.height/800
        text: "MAX:"
        font.pixelSize: 15 * root.width/400
        font.bold: true
        color: "white"
    }
    Text {
        x: 70
        y: 135 * root.height/800
        text: hVhigh
        font.pixelSize: 30 * root.width/400
        font.bold: true
        color: "white"
    }
}
