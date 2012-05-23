#ifndef EARIE_H
#define EARIE_H

#include <QObject>
#include <QString>
#include <QSettings>
#include <QList>
#include <QtNetwork/QNetworkAccessManager>
#include <gst/gst.h>

class Earie : public QObject
{
	Q_OBJECT
public:
	explicit Earie(QObject *parent = 0);

private:
	GstElement *recbin;
	GstElement *sink;

public slots:
	void record();
	void process();
	void parseResponse(QNetworkReply *);

};

#endif // EARIE_H
