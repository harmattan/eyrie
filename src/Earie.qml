import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
	id: rootWin;
	property int pageMargin: 16;
	property string artist;
	property string track;
	property string status;
	property bool showDetails: false;
	property bool showStatus: false;
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
