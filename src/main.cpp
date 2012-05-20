#include <QApplication>
#include <QDeclarativeContext>
#include <QDeclarativeView>
#include <QDebug>
#include <iostream>


void msgHandler( QtMsgType type, const char* msg )
{
	const char symbols[] = { 'I', 'E', '!', 'X' };
	QString output = QString("[%1] %2").arg( symbols[type] ).arg( msg );
	std::cerr << output.toStdString() << std::endl;
	if( type == QtFatalMsg ) abort();
}


int main(int argc, char *argv[])
{
	qInstallMsgHandler( msgHandler );
	QApplication app(argc, argv);
	app.setApplicationName("Earie");
	QDeclarativeView view;
	view.setSource(QUrl::fromLocalFile("Earie.qml"));
	//view.setSource(QUrl::fromLocalFile(DATADIR "/earie/Earie.qml"));
	QObject *root = (QObject*)(view.rootObject());
	QObject::connect((QObject*)view.engine(), SIGNAL(quit()), &app, SLOT(quit()));
	view.showFullScreen();
	return app.exec();
}

