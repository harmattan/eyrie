import QtQuick 1.1;
import com.nokia.meego 1.0;

Page {
	id: recordPage;
	anchors.margins: 0;

	Column {
		spacing: 10;
		anchors.bottom: btnFind.top;
		anchors.bottomMargin: 60;
		width: parent.width;

		Label {
			anchors.horizontalCenter: parent.horizontalCenter;
			visible: rootWin.showStatus;
			text: rootWin.status;
			horizontalAlignment: Text.AlignHCenter;
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
				wrapMode: Text.Wrap;
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
				wrapMode: Text.Wrap;
			}
		}
	
	}	

	Button {
		id: btnFind;
		anchors.bottom: parent.bottom;
		width: parent.width;
		text: rootWin.buttonText;
		anchors.margins: rootWin.pageMargin;
		onClicked: {
			rootWin.buttonText = "Cancel";
			rootWin.record();
		}
	}

}
