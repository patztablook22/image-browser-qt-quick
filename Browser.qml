import QtQuick 2.0
import Qt.labs.folderlistmodel 2.12

Rectangle {
    id: browser
    property string path
    property int size: 100
    property int columns: Math.round(width / size)

    anchors.fill: parent
    color: "black"

    onPathChanged: {
        console.log(path)
    }

    FolderListModel {
        id: folder
        showDotAndDotDot: true
        showDirsFirst: true
        folder: browser.path
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
                    browser.path = "file://" + filePath
                }
                hoverEnabled: true
            }

        }
    }

    GridView {
        id: grid
        anchors.fill: parent
        model: folder
        delegate: file
        boundsBehavior: Flickable.StopAtBounds
        cellWidth: browser.width / browser.columns
        cellHeight: cellWidth + 20
    }
}
