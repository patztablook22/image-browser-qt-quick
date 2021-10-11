import QtQuick 2.0

Item {
    id: viewer
    property string source
    property double scale: 1

    anchors.fill: parent

    Flickable {
        anchors.fill: parent
        contentWidth: Math.max(image.width * parent.scale, viewer.width)
        contentHeight: Math.max(image.height * parent.scale, viewer.height)
        boundsBehavior: Flickable.StopAtBounds

        Image {
            id: image
            source: viewer.source
            fillMode: Image.PreserveAspectFit
            scale: viewer.scale
            anchors.centerIn: parent

            MouseArea {
                anchors.fill: parent

                onWheel: {
                    let tmp = viewer.scale + wheel.angleDelta.y / 1000
                    if (tmp < 0.05)
                        tmp = 0.05
                    viewer.scale = tmp
                }
            }
        }
    }



}
