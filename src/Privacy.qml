import QtQuick 1.1;
import com.nokia.meego 1.0;

Page {
	id: privacyPage;
	anchors.margins: 32;
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
			text: "Privacy Policy";
			font.pixelSize: 34;
		}

		Label {
			wrapMode: Text.Wrap;
			horizontalAlignment: Text.AlignJustify;
			width: parent.width;
			text: "Eyrie records audio from your phone's microphone. This audio is never stored or transmitted over the Internet. Recorded audio is only ever used for generating acoustic fingerprints, which are used to determine what songs are currently playing nearby. These acoustic fingerprints are sent over the Internet to The EchoNest. It is not possible to reconstruct the recorded audio from acoustic fingerprints.";
		}

	}
}
