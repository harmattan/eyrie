#include <QApplication>
#include <QDeclarativeContext>
#include <QDeclarativeView>
#include <QDebug>
#include <iostream>
#include "eyrie.h"
#include <gst/gst.h>


void msgHandler(QtMsgType type, const char* msg) {
	const char symbols[] = { 'I', 'E', '!', 'X' };
	QString output = QString("[%1] %2").arg( symbols[type] ).arg( msg );
	std::cerr << output.toStdString() << std::endl;
	if( type == QtFatalMsg ) abort();
}


int main(int argc, char *argv[])
{
	gst_init(&argc, &argv);
	qInstallMsgHandler( msgHandler );
	QApplication app(argc, argv);
	app.setApplicationName("Eyrie");
	QDeclarativeView view;
	view.setSource(QUrl::fromLocalFile(DATADIR "/eyrie/Eyrie.qml"));
	QObject *root = (QObject*)(view.rootObject());
	Eyrie ear(root);
	QObject::connect((QObject*)view.engine(), SIGNAL(quit()), &app, SLOT(quit()));
	QObject::connect((QObject*)view.engine(), SIGNAL(quit()), &app, SLOT(quit()));
	QObject::connect(root, SIGNAL(record()), &ear, SLOT(record()));

	view.showFullScreen();
	int ret = app.exec();
	gst_deinit();
	return ret;
}

