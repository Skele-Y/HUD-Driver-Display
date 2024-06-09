import QtQuick 2.12

Item {
    property real fr: sensors.TyreIndicatorFR.toFixed(0)
    property real fl: sensors.TyreIndicatorFL.toFixed(0)
    property real rr: sensors.TyreIndicatorRR.toFixed(0)
    property real rl: sensors.TyreIndicatorRL.toFixed(0)
    property string colorFL: tyreTypeColorMap.TyreIndicatorFL
    property string colorFR: tyreTypeColorMap.TyreIndicatorFR
    property string colorBL: tyreTypeColorMap.TyreIndicatorRL
    property string colorBR: tyreTypeColorMap.TyreIndicatorRR
    property real widthScale: root.width/480
    property real heightScale: root.height/800

    Image {
        id: tyreimage
        x: 80 * widthScale
        y: 80 * heightScale
        transformOrigin: Center
        onScaleChanged: console.log(tyreimage.origin.x + tyreimage.origin.y)
        transform: Scale {xScale: 0.07923 * widthScale; yScale: 0.07923 * heightScale}
        source: "qrc:/resources/images/Pirelli_2019_C2.png"
        mipmap: true
        z: 4
    }

    Rectangle {
        id: fl_rect
        width: 105 * widthScale
        height: 105 * heightScale
        color: colorFL
        anchors {
            top: parent.top
            left: parent.left
        }
        Text {
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            text: fl + "C°"
            color: "white"
            font.family: "Roboto"
            font.pixelSize: 35 * heightScale
            font.styleName: "Bold"
        }
    }



    Rectangle {
        width: 105 * widthScale
        height: 105 * heightScale
        color: colorFR
        id: fr_rect
        anchors {
            left: fl_rect.right
        }
        Text {
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            text: fr + "C°"
            color: "white"
            font.family: "Roboto"
            font.pixelSize: 35 * heightScale
            font.styleName: "Bold"
        }
    }

    Rectangle {
        width: 105 * widthScale
        height: 105 * heightScale
        color: colorBL
        id: rl_rect
        anchors {
            top: fl_rect.bottom
        }
        Text {
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            text: rl + "C°"
            color: "white"
            font.family: "Roboto"
            font.pixelSize: 35 * heightScale
            font.styleName: "Bold"
        }
    }

    Rectangle {
        width: 105 * widthScale
        height: 105 * heightScale
        color: colorBR
        id: rr_rect
        anchors {
            top: fr_rect.bottom
            left: rl_rect.right
        }
        Text {
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            text: rr + "C°"
            color: "white"
            font.family: "Roboto"
            font.pixelSize: 35 * heightScale
            font.styleName: "Bold"
        }
    }


}
