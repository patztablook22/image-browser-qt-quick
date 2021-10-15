import QtQuick 2.3
import QtQuick.Controls 2.12

Popup {
        id: viewer
        property string source
        property real zoom: 1
        width: parent.width
        height: parent.height
        clip: true
        closePolicy: Popup.CloseOnEscape
        padding: 0

        function openFor(src) {
                source = src

                let tmp = Math.min(
                    viewer.width  / inner.width,
                    viewer.height / inner.height
                );

                // adjust image zoom only if the image is high resolution (keep low-resolution images small)
                if (tmp < 1)
                    zoom = tmp
                else
                    zoom = 1

                // open the popup
                open()
                zoomCenter()
        }

        function zoomCenter() {
                var zoomPoint = Qt.point(flickArea.width/2 + flickArea.contentX,
                                         flickArea.height/2 + flickArea.contentY);

                flickArea.resizeContent(
                    Math.max(inner.width * zoom, viewer.width),
                    Math.max(inner.height * zoom, viewer.height),
                    zoomPoint
                );
                flickArea.returnToBounds();
        }

        onZoomChanged: zoomCenter()
        onWidthChanged: zoomCenter()
        onHeightChanged: zoomCenter()

        Flickable {
                id: flickArea
                property alias image: inner
                property real imageAspectRatio: inner.width / inner.height
                anchors.fill: parent
                boundsBehavior: Flickable.StopAtBounds
                contentHeight: inner.height
                contentWidth: inner.width
                Image {
                        id: inner
                        scale: zoom
                        anchors.centerIn: parent
                        source: "file://" + viewer.source
                }

                MouseArea {
                        anchors.fill: parent
                        onWheel: {
                                let tmp = viewer.zoom + wheel.angleDelta.y / 1000
                                if (tmp < 0.1)
                                        tmp = 0.1
                                else if (tmp > 5)
                                        tmp = 5
                                viewer.zoom = tmp
                        }
                        preventStealing: false
                }

                // the rebound aniation zooming "jerky", turn it off
                rebound: Transition {}
        }

        Slider {
                id: slider
                orientation: Qt.Vertical
                anchors {
                        bottom: parent.bottom
                        right: parent.right
                        top: parent.top
                        topMargin: 10
                        rightMargin: 10
                        bottomMargin: viewer.height / 2
                }

                from: 0.1
                to: 5

                value: viewer.zoom
                onValueChanged: viewer.zoom = value
        }

        Map {
            container: flickArea
        }

}


