import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
	id: rootWin;
	property int pageMargin: 16;
	property string artist;
	property string track;
	property string status;
	property string imageUrl;
	property bool showDetails: false;
	property bool showStatus: false;
	property bool showImage: true;
	property string buttonText: "Find Song";

	initialPage: RecordPage { }

	signal record();

	Component.onCompleted: {
		theme.inverted = true;
	}
	
	function openFile(file) {
		var component = Qt.createComponent(file);
		if (component.status == Component.Ready) {
			pageStack.push(component);
		} else {
			console.log("Error loading component:", component.errorString());
		}
	}

	function setDetails(a, t) {
		artist = a;
		track = t;
		showStatus = false;
		showDetails = true;
		showImage = false;
	}

	function setStatus(s) {
		status = s;
		showDetails = false;
		showStatus = true;
	}

	function reset() {
		showDetails = false;
		showStatus = false;
		buttonText = "Find Song";
	}

	function resetButton() {
		buttonText = "Find Song";
	}

	function showImage(i) {
		img.source = i;
	}

	Image {
		z: -1;
		id: img;
		width: 480;
		smooth: true;
		fillMode: Image.PreserveAspectFit;
		source: "logo.png";
		anchors.top: parent.top;
	}

	Image {
		z: -1;
		anchors.top: img.bottom;
		anchors.topMargin: 20;
		source: "enlogo.png";
		anchors.horizontalCenter: parent.horizontalCenter;
	}

	ToolBarLayout {
		id: commonTools;
		visible: false;
		ToolIcon { 
			iconId: "toolbar-back";
			onClicked: { 
				pageStack.pop();
			}
		}
	}
}