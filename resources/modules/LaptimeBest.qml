import QtQuick 2.12

Rectangle {
    width: parent.width * 0.35
    height: parent.height * 0.35
    color: "black"
    id: best_laptime

    property real minutes_best : Math.floor(bestTimeSeconds / 60)
    property real seconds_best : Math.floor(bestTimeSeconds - minutes_best * 60)
    property real milliseconds_best : Math.floor(bestTimeSeconds * 1000)

    property real bestTimeSeconds: sensors["id-6002"].toFixed(3)


    Text {
        id: best_lap_times
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        color: "#FFFFFF"
        font.pixelSize: 90 * (root.height / 480)
        font.styleName: "Normal"
        font.weight: Font.Bold
        font.family: "Roboto"

        text: if (minutes_best >= 10) {
            "10mins+"
        } else if (minutes_best < 0) {
        } else {
            ('000' + minutes_best).slice(-1) + ":" + ('000' + seconds_best).slice(-2) + "." + ('000' + milliseconds_best).slice(-3, -1)
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:2}
}
##^##*/
