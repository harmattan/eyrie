#ifndef EYRIE_H
#define EYRIE_H

#include <QObject>
#include <QString>
#include <QSettings>
#include <QtNetwork/QNetworkReply>
#include <QDeclarativeView>
#include <QList>
#include <QTimer>
#include <gst/gst.h>
#include <gst/interfaces/xoverlay.h>

class Eyrie : public QObject
{
	Q_OBJECT
public:
	explicit Eyrie(QObject *parent, QDeclarativeView *v);

private:
	GstElement *recbin;
	GstElement *sink;
	GstElement *overlay;
	QTimer *timer;
	QDeclarativeView *view;

public slots:
	void record();
	void process();
	void parseResponse(QNetworkReply *reply);
	void showImage(QNetworkReply *reply);
};

#endif // EYRIE_H
