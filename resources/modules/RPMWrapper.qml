import QtQuick 2.12

//RPM_wrapper exists so that anchors ignore rotations in main.qml
Item {
    RPM_bar {
        id: rpm_bar
        anchors.left: root.left
        x: 200
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:100;width:640}
}
##^##*/
