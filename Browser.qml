import QtQuick 2.0
import Qt.labs.folderlistmodel 2.12

Rectangle {
    id: browser
    property string path

    anchors.fill: parent
    color: "black"

    onPathChanged: console.log(path)

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
                console.log(fileSuffix)
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

            color: "red"
            border.color: "green"
//            anchors.fill: parent
            width: 100
            height: 100

            Image {
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                source: {
                    if (fileIsDir)
                        "file:///home/patz/Work/folder.png"
                    else if (isImage())
                        "file://" + filePath
                    else
                        "file:///home/patz/Work/file.png"
                }
            }

            Text {
                color: "blue"
                text: fileName + (fileIsDir ? "/" : "")
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    browser.path = "file://" + filePath
                }
            }

        }
    }

    GridView {
        anchors.fill: parent
        model: folder
        delegate: file
    }

}
