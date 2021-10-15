import QtQuick 2.0
import QtQuick.Controls 2.12

Component {
    id: file

    Rectangle {
            clip: true

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
            width: Math.floor(browser.width / browser.columns)
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

            function open() {

                    if (fileName === "..") {
                            dir = folder.parentFolder.toString().split("file://")[1]
                            browser.activePath = dir
                    } else if (fileName === ".") {
                    } else if (fileIsDir) {
                            dir = filePath
                            browser.activePath = dir
                    } else if (!isImage()) {
                    } else {
                            // open Viewer
                            viewer.openFor(filePath)
                            browser.activePath = filePath
                    }
            }

            MouseArea {
                    id: mouse
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: {
                            if (mouse.button == Qt.RightButton) {
                                    // just open the context menu
                                    contextMenu.x = mouseX
                                    contextMenu.y = mouseY
                                    contextMenu.open()
                                    return
                            }
                            open()
                    }
                    hoverEnabled: true

                    Menu {
                            id: contextMenu
                            Action {
                                    text: "&Open"
                                    onTriggered: open()
                            }
                    }
            }

    }
}
