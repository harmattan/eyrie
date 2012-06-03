#ifndef EYRIE_H
#define EYRIE_H

#include <QObject>
#include <QString>
#include <QSettings>
#include <QtNetwork/QNetworkReply>
#include <QDeclarativeView>
#include <QList>
#include <QTimer>
#include <QMutex>
#include <gst/gst.h>
#include <gst/app/gstappsink.h>
#include <gst/interfaces/xoverlay.h>

class Eyrie : public QObject
{
	Q_OBJECT
public:
	explicit Eyrie(QObject *parent, QDeclarativeView *v);
	GstElement *recbin;
	GstElement *sink;
	GstBuffer *buf;
	QMutex *mutex;

private:
	GstElement *overlay;
	QTimer *timer;
	QDeclarativeView *view;
	int attempts;

public slots:
	void record();
	void endRecording();
	void process();
	void parseResponse(QNetworkReply *reply);
	void showImage(QNetworkReply *reply);
};

#endif // EYRIE_H
