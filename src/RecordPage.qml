import QtQuick 1.1;
import com.nokia.meego 1.0;

Page {
	id: recordPage;
	anchors.margins: rootWin.pageMargin;

	Column {
		spacing: 10;
		anchors.verticalCenterOffset: 30;
		anchors.centerIn: parent;
		width: parent.width;

		Label {
			anchors.horizontalCenter: parent.horizontalCenter;
			visible: rootWin.showStatus;
			text: rootWin.status;
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter;
			visible: rootWin.showDetails;
			Label {
				text: "Artist: ";
			}
			Label {
				id: lblArtist;
				text: rootWin.artist;
				elide: Text.ElideRight;
			}
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter;
			visible: rootWin.showDetails;
			Label {
				text: "Track: ";
			}
			Label {
				id: lblTrack;
				text: rootWin.track;
				elide: Text.ElideRight;
			}
		}
	
	}	

	Button {
		anchors.bottom: parent.anchors.bottom;
		width: parent.width;
		text: rootWin.buttonText;
		onClicked: {
			rootWin.buttonText = "Cancel";
			rootWin.record();
		}
	}

}
