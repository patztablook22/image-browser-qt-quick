import QtQuick 2.0
import Qt.labs.folderlistmodel 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle {
    id: browser

    /*
     * `dir` holds directory being browsed
     * `activePath` holds opened dir or file
     * `viewing` says whether the viewer is opened or not
     * `size` holds reference delegate width
     *        it is only reference as it will be adjusted to fit the total width of the browser
     * `columns` holds the number of grid columns (calculated from total width and icon width, see `size`)
     */

    property string dir
    property string activePath: dir
    property bool   viewing: viewer.opened
    property int    size: 100
    property int    columns: Math.round(width / size)

    anchors.fill: parent
    color: "black"

    FolderListModel {
        // list of entries in `dir`
        // directories first, files afterwards

        id: folder
        showDotAndDotDot: true
        showDirsFirst: true
        folder: "file://" + dir
    }

    Viewer {
        // image viewer, opened after triggering `FileDelegate`
        id: viewer
        onClosed: activePath = dir
    }

    ScrollView {
        anchors.fill: parent
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        clip: true

        GridView {
            // list the entries
            anchors.fill: parent
            model: folder
            delegate: FileDelegate {}
            cellWidth: Math.floor(browser.width / browser.columns)
            cellHeight: cellWidth + 20
            boundsBehavior: Flickable.StopAtBounds
        }
    }

}
