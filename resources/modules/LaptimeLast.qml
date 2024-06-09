import QtQuick 2.12

Rectangle {
    width: parent.width * 0.35
    height: parent.height * 0.35
    color: "transparent"
    id: last_laptime

    property real minutes_last : Math.floor(lastTimeSeconds / 60)
    property real seconds_last : Math.floor(lastTimeSeconds - minutes_last * 60)
    property real milliseconds_last : Math.floor(lastTimeSeconds * 100)
    property real lastTimeSeconds: sensors.lastLap.toFixed(3)

    Rectangle {
        width: parenth.width
        height: 2
        color: "green"
    }

    Text {
        id: last_lap_time
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        color: "#FFFFFF"
        font.pixelSize: 90 * (root.height / 800)
        font.styleName: "Normal"
        font.weight: Font.Bold
        font.family: "Arial"
        text: if (minutes_last >= 10) {
            "10mins+"
        } else if (minutes_last < 0) {
        } else {
            ('000' + minutes_last).slice(-1) + ":" + ('000' + seconds_last).slice(-2) + "." + ('00' + milliseconds_last).slice(-2)
        }
    }

}


