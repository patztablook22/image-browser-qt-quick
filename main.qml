import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true

//    Viewer {
//        anchors.fill: parent
//        source: "file:///home/patz/Keep/Gallerby/Gustave Doré/Divine Comedy 1.png"
//    }
    Browser {
        anchors.fill: parent
        path: "file:///home/patz/"
    }
}
