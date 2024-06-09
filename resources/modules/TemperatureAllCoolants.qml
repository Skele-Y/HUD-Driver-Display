import QtQuick 2.0

Rectangle {
    id: temperature_all
    width: root.width
    height: 100 * root.height/800
    color: "transparent"
    property real tempInv: sensors.coolantTempInverter.toFixed(0)
    property real tempFanOut: sensors.coolantTempFanOUT.toFixed(0)
    property real tempFanIn: sensors.coolantTempFanIN.toFixed(0)

    Rectangle {
        id: temperature_inv

        property bool isRed: false
        width: parent.width/3
        height: parent.height
        border {
            color: "white"
        }
        color: "transparent"


        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 20
            y: 8
            text: if (tempInv >= 100 || tempInv < 0) {
                  } else {
                      ('10' + tempInv).slice(-2) + "°C"
                  }
            font.pixelSize: 80 * root.width/800
            font.bold: true
            color: "white"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 65 * root.height/800
            text: "INV. TEMP"
            font.pixelSize: 13 * root.width/400
            font.bold: true
            color: "white"
        }
    }

    Rectangle {
        id: temperature_fanout
        width: parent.width/3
        height: parent.height
        x: temperature_fanout.width*1
        border {
            color: "white"
        }
        color: "transparent"


        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 20
            y: 8
            text: if (tempFanOut >= 100 || tempFanOut < 0) {
                  } else {
                      ('10' + tempFanOut).slice(-2) + "°C"
                  }
            font.pixelSize: 80 * root.width/800
            font.bold: true
            color: "white"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 65 * root.height/800
            text: "Fan Out. TEMP"
            font.pixelSize: 13 * root.width/400
            font.bold: true
            color: "white"
        }
    }


    Rectangle {
        id: temperature_fanin
        width: parent.width/3
        height: parent.height
        x: temperature_fanin.width*2
        border {
            color: "white"
        }
        color: "transparent"


        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 20
            y: 8
            text: if (tempFanIn >= 100 || tempFanIn < 0) {
                  } else {
                      ('10' + tempFanIn).slice(-2) + "°C"
                  }
            font.pixelSize: 80 * root.width/800
            font.bold: true
            color: "white"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 65 * root.height/800
            text: "Fan In. TEMP"
            font.pixelSize: 13 * root.width/400
            font.bold: true
            color: "white"
        }
    }
}

