import QtQuick 2.0
import Qt.labs.folderlistmodel 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle {
    id: browser
    property string dir
    property string activePath: dir
    property bool   viewing: viewer.opened
    property int size: 100
    property int columns: Math.round(width / size)

    anchors.fill: parent
    color: "black"

    onDirChanged: {
        console.log("browser source: " + dir)
    }

    FolderListModel {
        id: folder
        showDotAndDotDot: true
        showDirsFirst: true
        folder: "file://" + dir
    }

    Viewer {
        id: viewer
        onClosed: activePath = dir
    }


    ScrollView {
        anchors.fill: parent
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        clip: true

        GridView {
            anchors.fill: parent
            model: folder
            delegate: FileDelegate {}
            cellWidth: Math.floor(browser.width / browser.columns)
            cellHeight: cellWidth + 20
            boundsBehavior: Flickable.StopAtBounds
        }
    }

}
