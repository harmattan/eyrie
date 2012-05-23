#ifndef EARIE_H
#define EARIE_H

#include <QObject>
#include <QString>
#include <QSettings>
#include <QtNetwork/QNetworkReply>
#include <QList>
#include <QTimer>
#include <gst/gst.h>

class Eyrie : public QObject
{
	Q_OBJECT
public:
	explicit Eyrie(QObject *parent = 0);

private:
	GstElement *recbin;
	GstElement *sink;
	QTimer *timer;

public slots:
	void record();
	void process();
	void parseResponse(QNetworkReply *reply);
	void showImage(QNetworkReply *reply);
};

#endif // EARIE_H
