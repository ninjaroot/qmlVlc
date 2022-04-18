import QtQuick
import QtQuick.Window
import QtQuick.Dialogs
Window {
    id: main_wind
    width: 200
    height: 80
    visible: true
    color: "#252525"
    flags: "FramelessWindowHint"

    property var player_window_object:[]
    property bool max_min: true

    function openNewPlayer(filename) {
        var component = Qt.createComponent("PlayerWindow.qml");
        var object = component.createObject();
        object.filename = filename
        //   player_window_object[object] = object

    }

    signal playerWindowActivated(var _window)
    onPlayerWindowActivated : (_win) =>  {
                                  tools_window.activate(_win)




                              }



    Rectangle{
        id:toolbar
        width: main_wind.width
        height: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottomMargin: 10
        color: "#252525"

        Mybutton{
            id:close
            width: 15
            height: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            path: "qrc:/pixmaps/close.svg"
            onButtonClicked: {
                main_wind.close()
            }
        }

        Mybutton{
            id:manmize
            width: 15
            height: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: close.left
            anchors.rightMargin: 20
            path: "qrc:/pixmaps/maxmize.svg"
            onButtonClicked: {

                if(max_min ==true){
                    main_wind.visibility = "Maximized"
                    max_min = false
                    manmize.path ="qrc:/pixmaps/minimize.svg"
                    manmize.width =25
                    manmize.height =25
                }else{
                    main_wind.show()
                    max_min = true
                    manmize.path = "qrc:/pixmaps/maxmize.svg"
                    manmize.width =15
                    manmize.height =15
                }
            }
        }

        Mybutton{
            id:minimized_
            width: 15
            height: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: manmize.left
            anchors.rightMargin: 20
            path: "qrc:/pixmaps/mi.svg"
            onButtonClicked: {
                main_wind.visibility ="Minimized"
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a Video"
        nameFilters: ["*.mp4","*.flv","*.vob","*.avi","*.wmv","*.m4v"]
        onAccepted: {
            var videopath= currentFile+""
            videopath = videopath.substring(5)
            openNewPlayer(videopath)
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    Mybutton{
        id:select_video
        width: 100
        height: 30
        color: "gray"
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 20
        Text {
            id: name
            text: qsTr("Select Video")
            anchors.centerIn: parent
            color: "white"
        }
        onButtonClicked: {
            fileDialog.open()
        }

    }


    ToolsWindow{
        id:tools_window
        visible: false
    }
}
