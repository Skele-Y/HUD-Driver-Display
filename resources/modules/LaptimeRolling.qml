import QtQuick

Rectangle {
    id: laptime_rolling
    width: laptime_rolling_text.width
    height: laptime_rolling_text.height
    color: "transparent"

    property real floatSeconds: sensors["id-6001"].toFixed(3)
    property real minutes : Math.floor(floatSeconds / 60)
    property real seconds : Math.floor(floatSeconds - minutes * 60)
    property real milliseconds : Math.floor(floatSeconds * 1000)

    Text {
        id: laptime_rolling_text
        objectName: "Best Laptime"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#ffffff"
        wrapMode: Text.NoWrap
        text: ('000' + minutes).slice(-2) + ":" + ('000' + seconds).slice(-2) + "." + ('000' + milliseconds).slice(-3)
        font.family: "MS Shell Dlg 2"
        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 64
        font.weight: Font.Normal
    }



}
