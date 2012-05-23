import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: aboutPage
    anchors.margins: rootWin.pageMargin
    tools: commonTools

    Column {
        spacing: 10
        anchors.verticalCenterOffset: 30
        anchors.centerIn: parent

        Label {
            text: "Eyrie"
            font.pixelSize: 34
        }

        Label {
            text: "Released under the GPL, version 3.0 or later."
        }

        Label {
            text: "Mike Sheldon <elleo@gnu.org>"
        }

    }
}
