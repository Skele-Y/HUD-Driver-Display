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

    Image {
        source: "qrc:/resources/images/white_arrow.png"
        x: 30*root.width/480
    }
}
