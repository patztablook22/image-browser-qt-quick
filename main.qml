import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true

    // Windows 95 theme init :cringe:
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
        dir: HOME_PATH
        // `HOME_PATH` registered in main.cpp
    }

    statusBar: Status {
        activePath: browser.activePath
    }

}
