import QtQuick 2.12

Item {
    property real floatTemp: sensors.temperatureSoC.toFixed(3)
    property real percentage: ((floatTemp - 20)/40) * 358
    Rectangle {
        id: temperature_bar
        width: 199
        height: 366
        color: "transparent"
        Image {
            id: temp_bar_image
            x:0
            y:0
            width: 199
            height: 366
            source: "qrc:/resources/images/Temperature Bar.png"
            fillMode: Image.PreserveAspectFit
            transform: Scale { id: scaleimg; xScale: root.width/1024; yScale: root.height/600}
            smooth: false
        }
    }
    Rectangle {
        x: 51 * root.width/1024
        y: if (floatTemp <= 20) {
                360 * root.height/600
           } else if (floatTemp > 60) {
                2 * root.height/600
           } else {
                360 * root.height/600 - percentage * root.height/600
           }

        height: 6 * root.height/600
        width: 148 * root.width/1024
        color: "red"
        Rectangle {
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter
            height: 12 * root.height/600
            width: 4 * root.width/1024
            color: "red"
        }
        Rectangle {
            anchors.right:parent.right
            anchors.verticalCenter: parent.verticalCenter
            height: 12 * root.height/600
            width: 4 * root.width/1024
            color: "red"
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:366;width:148}
}
##^##*/
