import QtQuick 2.0
import QtQuick.Controls 2.14

Item {
    id:root
    property int s_value: 0
    property int s_from: 0
    property int s_to: 0
    property int s_stepsize: 0
    property string s_text:""
Column {
        spacing: 10
        anchors.fill: parent

    Slider {
        id: control
        width:root.width
        height: root.height*1.2
        from: s_from
        value:s_value
        to:s_to
        stepSize: s_stepsize
        onValueChanged:{
            s_value = value
        }

        background: Rectangle {
            x: control.leftPadding
            y: control.topPadding + control.availableHeight / 2 - height / 2
            implicitWidth: root.width
            implicitHeight: 4
            width: control.availableWidth
            height: implicitHeight
            radius: 8

            color: "black"
            Rectangle {
                width: control.visualPosition * parent.width
                height: parent.height
                color: "#00b4bc"
                radius: 8

            }
        }
        handle: Rectangle {
            id:hand
            x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
            y: control.topPadding + control.availableHeight / 2 - height / 2
            implicitWidth: 12
            implicitHeight: 12
            radius: 6
            color: control.pressed ? "#8fdfe3" : "#f6f6f6"
            border.color: "#bdbebf"

        }
    }
    }
}

