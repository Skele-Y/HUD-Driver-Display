import QtQuick 2.12

Item {
    id: state_of_charge
    objectName: "State of Charge"

    property real socValue: {
        if (sensors.StateOfCharge > 1)
            return 1
        else if (sensors.StateOfCharge < 0)
            return 0
        else return sensors.StateOfCharge
    }

    height: state_of_charge_rect.height
    width: state_of_charge_rect.width

    Rectangle {
        id: state_of_charge_rect
        z: 2
        color: "red"
        transformOrigin: Item.BottomLeft
        width: 148
        height: 340
        transform: Scale { id: scalerect; origin.x: 0; origin.y: Rectangle.height; xScale: root.width/800; yScale: socValue * (-root.height/480)} 
    }

    Rectangle {
        id: soc_back
        z: 1
        color: "#4F4F4F"
        transformOrigin: Item.BottomLeft
        width: 148
        height: 340
        transform: Scale { id: scalerect2; origin.x: 0; origin.y: Rectangle.height; xScale: root.width/800; yScale: (-root.height/480)}
    }

    Column {
        id: bat_column
        x: 0
        y: ((-340*root.height/480)*4)/5
        z: 3
        Rectangle { id: col_len; width: state_of_charge_rect.width; height: 10; color: "#151515"; transform: Scale {xScale: root.width/800; yScale: root.height/480}}
        Rectangle { width: state_of_charge_rect.width; height: 10; color: "#151515"; transform: Scale {xScale: root.width/800; yScale: root.height/480}}
        Rectangle { width: state_of_charge_rect.width; height: 10; color: "#151515"; transform: Scale {xScale: root.width/800; yScale: root.height/480}}
        Rectangle { width: state_of_charge_rect.width; height: 10; color: "#151515"; transform: Scale {xScale: root.width/800; yScale: root.height/480}}
        spacing: ((340*root.height/480)/ 5) - col_len.height
    }

    states: [
        State {
            name: "yellow"
            when: socValue >= 0.5 && socValue < 0.8
            PropertyChanges {
                target: state_of_charge_rect
                color: "#efdb4c"
            }
        },
        State {
            name: "green"
            when: socValue >= 0.8
            PropertyChanges {
                target: state_of_charge_rect
                color: "#6bef4c"
            }
        }
    ]
}




/*##^##
Designer {
    D{i:0;height:340;width:148}
}
##^##*/
