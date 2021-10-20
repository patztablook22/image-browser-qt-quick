import QtQuick 2.0
import QtQuick.Controls 1.3

StatusBar {
        id: statusbar
        property alias activePath: text.text

        // just display the active path, idk what else
        Text {
            id: text
        }
}
