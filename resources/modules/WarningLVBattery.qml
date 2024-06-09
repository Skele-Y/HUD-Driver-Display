import QtQuick 2.12
import QtQuick.Controls 2.15

Item {
    property real lvBatt: sensors.lowVoltage.toFixed(2)
    id: lv_warning
    implicitWidth: lv_warning_panel.width
    implicitHeight: lvwarning_panel.height

    Rectangle {
        id: lv_warning_panel
        color: "#EC273D"
        width: root.width
        implicitHeight:lv_warning_text.height + 50
        visible: true
        opacity: 0
        Text {
            id: lv_warning_text
            width: parent.width
            text: "LV BATTERY TOO LOW"
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

        running: if (lvBatt < 11.2) {
                     true
                 } else {
                     false
                     lv_warning_panel.opacity = 0;
                 }
        onTriggered:  lv_warning_panel.opacity = (lv_warning_panel.opacity == 0) ? 1 : 0;
    }
}
