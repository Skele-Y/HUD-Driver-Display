import QtQuick 2.12

Rectangle {

    Text {
        id: gforce
        anchors {
            right: parent.left
        }

        color: "white"
        text: "0Gs"
        font.pixelSize: 40 * (root.height / 480)
        font.styleName: "Normal"
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    Rectangle {
        width: 68
        height: 165
        color: "transparent"
        border.color: "white"
        border.width: 3
        x: 80*root.width/480
        y: -60*root.height/800
    }
}
