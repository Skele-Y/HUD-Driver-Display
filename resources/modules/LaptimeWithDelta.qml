import QtQuick 2.0

Rectangle {
    id: laptime_counter
    width: 350
    height: 170
    color: "black"

    property real floatSeconds: sensors["id-6001"].toFixed(3)
    property real minutes : Math.floor(floatSeconds / 60) % 60
    property real seconds : Math.floor(floatSeconds - minutes * 60)
    property real milliseconds : Math.floor(floatSeconds * 1000)



    Text {
        id: laptime_rolling
        objectName: "Best Laptime"
        x: 32
        y: 17
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#ffffffff"
        wrapMode: Text.NoWrap
        text: ('000' + (Math.floor(floatSeconds / 60) % 60)).slice(0,2) + ":" + ('000' + (Math.floor(floatSeconds - minutes * 60))).slice(0,2) + ":" + ('000' + (Math.floor(floatSeconds * 1000))).slice(0,2)
        font.family: "MS Shell Dlg 2"
        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 64
        font.weight: Font.Normal
    }


    Text {
        id: laptime_delta_text
        x: 33
        objectName: "Laptime Delta"
        y: 50
        color: "#ffff4040"
        wrapMode: TextEdit.WordWrap
        anchors.verticalCenterOffset: 47
        text: "+0.000s"
        font.family: "MS Shell Dlg 2"
        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 64

        font.weight: Font.Normal
        anchors.verticalCenter: parent.verticalCenter


    }
}
