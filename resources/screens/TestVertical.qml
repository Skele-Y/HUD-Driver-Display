import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2
import QtQuick.Layouts 1.3
import "../modules/"

Item {
    id: root
    width: parent.width
    height: parent.height
    visible: true

    Rectangle {
        id: background_colour
        visible: true
        anchors.fill: parent
        color: "#151515"

//        TemperatureAllCoolants {
//            x: 0 * root.width/480
//            y: 200 * root.height/800
//        }

        TemperatureAccuDigital {
            x: 0 * root.width/480
            y: 0 * root.height/800
        }
        TemperatureMotor {
            y: 0 * root.height/800
            anchors.horizontalCenter: parent.horizontalCenter
        }
        TemperatureInverter {
            y: 0 * root.height/800
            anchors.right: parent.right
        }
        RegenStrength {
            y: 100 * root.height/800
            anchors.right: parent.right
        }
        TorqueSetting {
            y: 100 * root.height/800
            anchors.horizontalCenter: parent.horizontalCenter
        }
        LaunchControlSymbol{
            x: 275*root.width/480
            y: 260*root.height/800
        }
        CruiseControlSymbol {
            x: 252 * root.width/480
            y: 400 * root.height/800
        }
        LaptimeDelta {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 620 *root.height/800
        }
        LaptimeLast {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 600
        }
        HighVoltage {
            x: 0*root.width/480
            y: 230*root.height/800
        }
        LV {
            x: 0*root.width/480
            y: 430*root.height/800
        }
        DCL {
            y: 100 * root.height/800
            x: 0
        }
        WarningSoCTemp {
            z:150;
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.verticalCenterOffset: -300
        }
        WarningLVBattery {
            z:150;
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.verticalCenterOffset: -100
        }

//        TyreIndicators {
//            x: 240*root.width/480
//            y: 220*root.height/800
//        }
    }
}
