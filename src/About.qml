import QtQuick 1.1;
import com.nokia.meego 1.0;

Page {
	id: aboutPage;
	anchors.margins: rootWin.pageMargin;
	orientationLock: PageOrientation.LockPortrait;
	tools: commonTools;

	Column {
		spacing: 10;
		anchors.verticalCenterOffset: 30;
		anchors.centerIn: parent;
		width: parent.width;

		Label {
			width: parent.width;
			horizontalAlignment: Text.AlignHCenter;
			text: "Eyrie";
			font.pixelSize: 34;
		}

		Label {
			wrapMode: Text.Wrap;
			horizontalAlignment: Text.AlignHCenter;
			width: parent.width;
			text: "Author: Mike Sheldon <elleo@gnu.org>\n\nReleased under the GPL, version 3.0 or later.";
		}

	}
}
