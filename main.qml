import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true

    menuBar: MenuBar {
        Menu {
            title: "&File"
            MenuItem {
                text: "&Quit"
                shortcut: "ctrl+q"
                onTriggered: Qt.quit()
            }

        }
    }

    Browser {
        id: browser
        path: HOME_PATH
        // `HOME_PATH` registered in main.cpp
    }

    statusBar: StatusBar {
        id: statusbar
            Text {
                text: browser.path
            }

            Slider {
                orientation: Qt.Horizontal
                anchors.right: parent.right
            }

    }

}
