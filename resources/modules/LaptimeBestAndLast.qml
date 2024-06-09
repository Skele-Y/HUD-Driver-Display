import QtQuick 2.0

Rectangle {
    width: 280
    height: 480
    color: "black"
    id: best_and_last_laptime

    property real minutes_last : Math.floor(lastTimeSeconds / 60)
    property real seconds_last : Math.floor(lastTimeSeconds - minutes_last * 60)
    property real milliseconds_last : Math.floor(lastTimeSeconds * 1000)

    property real minutes_best : Math.floor(bestTimeSeconds / 60)
    property real seconds_best : Math.floor(bestTimeSeconds - minutes_best * 60)
    property real milliseconds_best : Math.floor(bestTimeSeconds * 1000)

    property real lastTimeSeconds: sensors["id-6004"].toFixed(3)
    property real bestTimeSeconds: sensors["id-6002"].toFixed(3)


    Text {
        id: title_last
        x: 23
        y: 73
        width: 138
        height: 87
        color: "#A1A1A1"
        text: qsTr("LAST")
        font.pixelSize: 60
        font.bold: true
    }

    Text {
        id: last_lap_time
        x: 23
        y: 152
        color: "#FFFFFF"
        font.pixelSize: 58
        text: if (minutes_last >= 10) {
            "10mins+"
        } else if (minutes_last < 0) {
            "NaN"
        } else {
            ('000' + minutes_last).slice(-1) + ":" + ('000' + seconds_last).slice(-2) + "." + ('000' + milliseconds_last).slice(-2)
        }  
    }

    Text {
        id: title_best
        x: 23
        y: 243
        width: 138
        height: 87
        color: "#A1A1A1"
        text: qsTr("BEST")
        font.pixelSize: 60
        font.bold: true
    }

    Text {
        id: best_lap_time
        x: 23
        y: 325
        color: "#FFFFFF"
        font.pixelSize: 58
        text: if (minutes_best >= 10) {
            "10mins+"
        } else if (minutes_best < 0) {

        } else {
            lowest_best: ('000' + minutes_best).slice(-1) + ":" + ('000' + seconds_best).slice(-2) + "." + ('000' + milliseconds_best).slice(-2)
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
