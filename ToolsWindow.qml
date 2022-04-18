import QtQuick 2.15
import QtQuick.Controls 2.15

Window{
    id:tool
    width: 640
    height: 480
    color: "#00000000"
    visible: false
    flags: "ToolTip"

    property var current_player:null
    property bool player_status: true
    property bool full_screen: false
    property bool max_min: true


    function activate(_win) {
        current_player = _win
        tool.x = _win.x
        tool.y = _win.y
        tool.width = _win.width
        tool.height = _win.height
        tool.visible = true
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            tool.visible = false
        }
    }

    //////////////////////////////////////**//////////////////////////

    Rectangle{
        id:toolbar
        width: tool.width
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
             current_player.close()
             tool.close()
             current_player.stop()

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
                    current_player.showMaximized()
                    max_min = false
                    manmize.path ="qrc:/pixmaps/minimize.svg"
                    manmize.width =25
                    manmize.height =25
                }else{
                    current_player.show()
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
            current_player.showMinimized()
            }
        }


    }



    Rectangle{
        id:toolbar_
        width: tool.width
        height: 30
        radius: 5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        color: "#252525"

        Myslider{
            id: video_poss
            width: tool.width/3
            height:20
            s_from: 0
            s_to: 100
            anchors.centerIn: parent
            onS_valueChanged:{
                if(current_player  != null)
                    current_player.changePosition(s_value*10)
            }
        }

        Myslider{
            id: volume
            width: 50
            height:20
            s_from: 0
            s_to: 200
            s_value: 80
            s_stepsize: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: video_poss.right
            anchors.leftMargin: 10
            onS_valueChanged:{
                if(current_player  != null)
                    current_player.changeVolume(s_value)

            }
        }

        Mybutton{
            id:play_button
            width: 25
            height: 25
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            path: "qrc:/pixmaps/stop.svg"


            onButtonClicked: {
                if(current_player  != null){
                    if(player_status ==true){
                        current_player.play()
                        player_status = false
                        play_button.path = "qrc:/pixmaps/play.svg"
                    }else{
                        current_player.play()
                        player_status = true
                        play_button.path = "qrc:/pixmaps/stop.svg"

                    }
                }
            }

        }

        Mybutton{
            id:fullscreen
            width: 25
            height: 25
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            path: "qrc:/pixmaps/toolbar/fullscreen.svg"
            onButtonClicked: {

                if (full_screen == false){
                    current_player.showFullScreen()

                    full_screen = true
                }
                else{
                    current_player.show()

                    full_screen = false
                }
            }
        }

    }
}
