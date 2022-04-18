import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle{
    id: botton_box
    property color darkClolor: "#404040"
    property string path: ""
    property string textData: ""
    signal buttonClicked()

    radius: width /2
    color: "transparent"
    Image {
        id: _image
        source:path
        smooth: true
        anchors.fill: parent
        anchors.centerIn: parent
    }
    MouseArea{
        id: mouse
        anchors.fill: parent
        onClicked: {
         buttonClicked()
        }
        onPressed: botton_box.color ="black"
        onReleased: botton_box.color ="transparent"

    }

    transitions: Transition {
        from: ""
        to: "act"
        ParallelAnimation {
            ColorAnimation {
                duration: 50
            }
        }
    }
}
