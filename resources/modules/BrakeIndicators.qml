import QtQuick 2.12

Item {
    property real fr: sensors.brakeIndicatorFR.toFixed(0)
    property real fl: sensors.brakeIndicatorFL.toFixed(0)
    property real rr: sensors.brakeIndicatorRR.toFixed(0)
    property real rl: sensors.brakeIndicatorRL.toFixed(0)

    function colorToHex(color) {
      var hexadecimal = color.toString(16);
      return hexadecimal.length === 1 ? "0" + hexadecimal : hexadecimal;
    }

    function convertRGBtoHex(red, green, blue) {
      return "#" + colorToHex(red) + colorToHex(green) + colorToHex(blue);
    }


    function tempToColor(temp) {
        var r_value = -50;
        var g_value = -50;
        var b_value = -50;

        var c_string;
        if (temp > 100 || temp < 0) {
            return;
        }
        else if (temp <= 50) {
            r_value = 0.04*fl+80;
        }
        else if (temp> 50) {
            r_value = 3.46*fl-91;
        }

        g_value = 173.9 - 8.003*Math.cos(temp*0.04446) + 81.95*Math.sin(temp*0.04446)
            + 15.04*Math.cos(2*temp*0.04446) - 11.27*Math.sin(2*temp*0.04446)
            + 4.298*Math.cos(3*temp*0.04446) - 5.283*Math.sin(3*temp*0.04446)
            - 3.781*Math.cos(4*temp*0.04446) - 0.9195*Math.sin(4*temp*0.04446);

        b_value = 133.9 + 76.63*Math.cos(temp*0.04789) + 30.65*Math.sin(temp*0.04789)
            + 28.33*Math.cos(2*temp*0.04789) + 15.33*Math.sin(2*temp*0.04789)
            + 9.802*Math.cos(3*temp*0.04789) - 3.894*Math.sin(3*temp*0.04789)
            + 5.089*Math.cos(4*temp*0.04789) - 3.058*Math.sin(4*temp*0.04789);

        r_value = Math.round(r_value);
        g_value = Math.round(g_value);
        b_value = Math.round(b_value);

        if (g_value > 255) {
            g_value = 255;
        }
        if (b_value > 255) {
            b_value = 255;
        }

        c_string = convertRGBtoHex(r_value, g_value, b_value);
        return c_string;
    }



    Rectangle {
        width: 105 * root.width/1024
        height: 105 * root.height/600
        color: tempToColor(fl)
        id: fl_rect
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
            font.pixelSize: 35 * (root.height / 480)
            font.styleName: "Bold"
        }
    }
    Rectangle {
        width: 105 * root.width/1024
        height: 105 * root.height/600
        color: tempToColor(fr)
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
            font.pixelSize: 35 * (root.height / 480)
            font.styleName: "Bold"
        }
    }

    Rectangle {
        width: 105 * root.width/1024
        height: 105 * root.height/600
        color: tempToColor(rl)
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
            font.pixelSize: 35 * (root.height / 480)
            font.styleName: "Bold"
        }
    }

    Rectangle {
        width: 105 * root.width/1024
        height: 105 * root.height/600
        color: tempToColor(rr)
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
            font.pixelSize: 35 * (root.height / 480)
            font.styleName: "Bold"
        }
    }


}
