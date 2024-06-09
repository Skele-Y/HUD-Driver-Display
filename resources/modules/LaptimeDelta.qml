import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Rectangle {
    id: laptime_delta
    implicitWidth: root.width
    height: 60 * root.height/800
    color: "transparent"

    property real floatSeconds_delta: sensors.lapDelta.toFixed(3)
    property real minutes_delta : Math.floor(floatSeconds_delta / 60)
    property real seconds_delta : Math.floor(floatSeconds_delta)
    property real neg_seconds_delta : Math.ceil(floatSeconds_delta)
    property real milliseconds_delta : Math.floor(floatSeconds_delta * 1000)

    Text {
        id: laptime_delta_text
        objectName: "Laptime Delta"
        color: "#ffffff"
        y: 0
        x: 0  
        wrapMode: TextEdit.WordWrap
        anchors {
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: 0
            horizontalCenter: parent.horizontalCenter
        }
        text: 'Uninit'
        font.family: "Arial"
        font.italic: false
        font.bold: true
        font.letterSpacing: 0
        font.pixelSize: 50
        font.weight: Font.Bold
        horizontalAlignment: root.AlignHCenter
    }

    states: [
        State {
            name: "faster"; when: floatSeconds_delta < 0
            PropertyChanges {
                target: laptime_delta; color: "#b400fe"
            }
            PropertyChanges {
                target: laptime_delta_text
                text: if (neg_seconds_delta == 0) {
                          "-" + (neg_seconds_delta) + "." + ('000' + (milliseconds_delta*-1)).slice(-3) + "s"
                      }
                      else {
                          (neg_seconds_delta) + "." + ('000' + milliseconds_delta).slice(-3) + "s"
                      }
            }
            StateChangeScript {
                name: "firstScript"
                script: console.log("milliseconds_delta is ", ('000' + milliseconds_delta).slice(-3),
                                    "negsecondsdelta is ", neg_seconds_delta)
            }
        },
        State {
            name: "slower"; when: floatSeconds_delta > 0
            PropertyChanges {
                target: laptime_delta
                color: "#fe0100"
            }
            PropertyChanges {
                target: laptime_delta_text
                text: if (seconds_delta < 10) {
                          "+" + seconds_delta + "." + ('000' + milliseconds_delta).slice(-3) + "s"
                      }
                      else if (seconds_delta >= 10) {
                          "+" + seconds_delta + "." + ('000' + milliseconds_delta).slice(-3) + "s"
                      }
            }
        },
        State {
            name: "neutral"; when: floatSeconds_delta == 0
            PropertyChanges {
                target: laptime_delta
                color: "#00ce01"
            }
            PropertyChanges {
                target: laptime_delta_text
                text: "+0.000s"
            }
        }
    ]
}





/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
