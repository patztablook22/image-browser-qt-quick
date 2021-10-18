import QtQuick 2.0
import QtQuick.Controls 1.3

StatusBar {
        id: statusbar

        // just display the active path, idk what else
        Text {
                text: browser.activePath
        }
}
