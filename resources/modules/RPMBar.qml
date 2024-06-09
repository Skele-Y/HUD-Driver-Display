import QtQuick 2.12
//x and y coordinates have been swapped due to 270 rotation
//it's confusing ik

Rectangle {
    id: rpm_bar
    width: root.height * 0.1625
    height: root.width
    color: "#008000"
    transformOrigin: Item.Center
    rotation: 270
    property real rpm_curr : sensors.rpmValue

    anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
        verticalCenterOffset: -parent.height/2 + width/2
    }

    gradient: Gradient {
        GradientStop {position: 0.0; color: "green"; }
        GradientStop {position: 0.5; color: "yellow"; }
        GradientStop {position: 1; color: "red"; }
    }
    Rectangle {
        id: rpm_mask
        color: "#151515"
        width: parent.height
        height: (1 - (rpm_curr/7000)) * (root.width)
        anchors {
            bottom: parent.bottom
        }
    }
    Column {
        y: 0
        //anchors the top to the top (since rectangles are rotated, right is the top)
        anchors.right: parent.right
        spacing: root.width/14 - 3
        z:3
        Rectangle { width: 50; height: 3; color: "transparent"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#444444"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#444444"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#444444"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#444444"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#444444"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#444444"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#444444"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#444444"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#444444"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#444444"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#d40000"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#d40000"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#d40000"}
        Rectangle { width: root.height * 0.1625; height: 3; color: "#d40000"}
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75;height:78;width:800}
}
##^##*/
