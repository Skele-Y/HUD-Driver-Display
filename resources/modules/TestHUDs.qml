import QtQuick 2.12

Item {
    property real testValue: sensors.Test1BigColor.toFixed(0)

    // random number from 500 to 5000 (milliseconds)
    property real randomTimer: getRndInteger(500,10000)


    function getRndInteger(min, max) {
      return Math.floor(Math.random() * (max - min) ) + min;
    }

    Timer {
            id: timer
            interval: getRndInteger(500,10000)
    }

    Item {
        id: test1_item
        width: 105 * root.width/1024
        height: 105 * root.height/600

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        Image {

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            source: "qrc:/resources/images/LeftArrow.png"
        }


    }
    Item {
        id: test2_item
        width: 105 * root.width/1024
        height: 105 * root.height/600

        Rectangle {
            width: 43
            height: 43
            color: "green"
        }
        Rectangle {
            width: 43
            height: 43
            color: "red"
        }
    }
    Item {
        id: test3_item
        width: 105 * root.width/1024
        height: 105 * root.height/600

        Rectangle {

        }
    }

    states: [
        State {
            name: "Test1BigColor"
            when: testValue == 1
            PropertyChanges {
                target: test1_item
                visible: true
            }
        },
        State {
            name: "test2"
            when: testValue == 2
            PropertyChanges {
                target: test2_item
                visible: true
            }
        },
        State {
            name: "test3"
            when: testValue == 3
            PropertyChanges {
                target: test3_item
                visible: true
            }
        }
    ]

}
