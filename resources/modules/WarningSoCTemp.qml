import QtQuick 2.12
import QtQuick.Controls 2.15

Item {
    property real floatTemp: sensors.temperatureSoC.toFixed(0)
    id: temperature_warning
    implicitWidth: temperature_warning_panel.width
    implicitHeight: temperature_warning_panel.height

    Rectangle {
        id: temperature_warning_panel
        color: "#EC273D"
        width: root.width
        implicitHeight:temperature_warning_text.height + 50
        visible: true
        opacity: 0
        Text {
            id: temperature_warning_text
            width: parent.width
            text: "ACCU TEMPERATURE TOO HIGH"
            color: "white"
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            font.family: "Roboto"
            font.pixelSize: 35 * (root.height / 800)
            font.styleName: "Bold"
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }
    }

    Timer {
        id: blink_timer
        interval: 300
        repeat: true

        running: if (floatTemp >= 55) {
                     true
                 } else {
                     false
                     temperature_warning_panel.opacity = 0;
                 }
        onTriggered:  temperature_warning_panel.opacity = (temperature_warning_panel.opacity == 0) ? 1 : 0;
    }
}
