import QtQuick 1.1;
import com.nokia.meego 1.0;

Page {
	id: recordPage;
	anchors.margins: 0;
	orientationLock: PageOrientation.LockPortrait;
	tools: recordTools;

	Column {
		spacing: 10;
		anchors.bottom: parent.bottom;
		anchors.bottomMargin: recordTools.height - 20;
		width: parent.width;

		Label {
			anchors.horizontalCenter: parent.horizontalCenter;
			visible: rootWin.showStatus;
			text: rootWin.status;
			horizontalAlignment: Text.AlignHCenter;
			width: parent.width;
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

	ToolBarLayout {
		id: recordTools;
		visible: true;

		Button {
			id: btnFind;
			width: parent.width - menuIcon.width - 34;
			anchors.left: parent.left;
			anchors.leftMargin: 16;
			text: rootWin.buttonText;
			onClicked: {
				rootWin.buttonText = "Cancel";
				rootWin.record();
			}
		}

		Image {
			id: menuIcon;
			height: btnFind.height;
			fillMode: Image.PreserveAspectFit;
			smooth: true;
			anchors.right: parent.right;
			anchors.rightMargin: 10;
			source: "image://theme/icon-m-toolbar-view-menu-white";
			MouseArea {
				anchors.fill: parent;
				onClicked: toolMenu.open();
			}
		}

	}

	Menu {
		id: toolMenu;
		content: MenuLayout {

			MenuItem {
				text: "Privacy Policy";
				onClicked: {
					rootWin.fadeImages();
					rootWin.openFile("Privacy.qml");
				}
			}

			MenuItem {
				text: "About";
				onClicked: {
					rootWin.fadeImages();
					rootWin.openFile("About.qml");
				}
			}
		}
	}
}
