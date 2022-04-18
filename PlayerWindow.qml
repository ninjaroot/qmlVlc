import QtQuick 2.0
import VlcItemWindow

VlcItemWindow{
    id:player_win
    property string player_win: "player_win"
    property string filename: ""
    property string visibility: ""

    width: 600
    height: 480
    visible: true
    color: "black"

    onFilenameChanged:
        openFile(filename)

    MouseArea{
        anchors.fill: parent
        onClicked:
            playerWindowActivated(player_win)
    }
}
