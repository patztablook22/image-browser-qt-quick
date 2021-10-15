import QtQuick 2.0
import Qt.labs.folderlistmodel 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle {
    id: browser
    property string path: path
    property int viewing: 0
    property int size: 100
    property int columns: Math.round(width / size)

    anchors.fill: parent
    color: "black"

    onPathChanged: {
        console.log("browser source: " + path)
    }

    FolderListModel {
        id: folder
        showDotAndDotDot: true
        showDirsFirst: true
        folder: "file://" + path
    }

    Viewer {
        id: viewer
    }

    Component {
        id: file

        Rectangle {

            function isImage() {
                switch (fileSuffix) {
                case "png":
                case "jpg":
                case "jpeg":
                case "gif":
                    return true
                default:
                    return false
                }
            }

            color: mouse.containsMouse ? "gray" : "transparent"
            width: browser.width / browser.columns
            height: width + text.height

            Item {
                anchors.fill: parent
                anchors.margins: 10

                Image {
                    x: 0
                    y: 0
                    width: parent.width
                    height: width
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                    source: {
                        if (fileIsDir)
                            "qrc:/icons/folder.png"
                        else if (isImage())
                            "file://" + filePath
                        else
                            "qrc:/icons/file.png"
                    }
                }

                Text {
                    id: text
                    anchors.bottom: parent.bottom
                    x: 10
                    width: parent.width - 20
                    color: "white"
                    text: fileName
                    elide: Text.ElideRight
                }
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
                onClicked: {
                    if (fileName === "..") {
                        path = folder.parentFolder.toString().split("file://")[1]
                    } else if (fileName === ".") {
                    } else if (fileIsDir) {
                        path = filePath
                    } else if (!isImage()) {
                    } else {
                        // open Viewer
//                        viewer.source = filePath
//                        viewer.open()
                        viewer.openFor(filePath)
                    }
                }
                hoverEnabled: true
            }

        }
    }

    ScrollView {
        anchors.fill: parent
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        clip: true

        GridView {
            anchors.fill: parent
            model: folder
            delegate: file
            cellWidth: browser.width / browser.columns
            cellHeight: cellWidth + 20
            boundsBehavior: Flickable.StopAtBounds
        }
    }

}
