import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2
import QtQuick.Layouts 1.3
import "resources/screens"

Item {
    id: root
    width: parent.width
    height: parent.height
    visible: true

    StackView {
        id: stackView
        initialItem: mainWide
        anchors.fill: parent
        }

    Component {
        id: mainWide
        MainWide {
            anchors.fill: parent
//            Button {
//                text: "test button"
//                onClicked: stackView.push(accelerationVertical)
//            }
        }
    }   

    Component {
        id: accelerationVertical
        AccelerationVertical {
            anchors.fill: parent
//            Button {
//                text: "test button 2"
//                onClicked: stackView.push(skidpanVertical)
//            }
        }
    }

    Component {
        id: skidpanVertical
        SkidpadVertical {
            anchors.fill: parent
//            Button {
//                text: "test button 3"
//                onClicked: {stackView.pop(null)}
//            }
        }
    }
}



