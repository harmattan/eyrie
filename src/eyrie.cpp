#include <QDebug>
#include <QTimer>
#include <QDateTime>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QUrl>
#include <qjson/parser.h>
#include <gst/gst.h>
#include <gst/app/gstappsink.h>
#include <Codegen.h>
#include <string.h>
#include "eyrie.h"


Eyrie::Eyrie(QObject *parent, QDeclarativeView *v) : QObject(parent) {
	recbin = NULL;
	view = v;
	timer = new QTimer(this);
	connect(timer, SIGNAL(timeout()), this, SLOT(process()));
}


void Eyrie::record() {
	QVariant ret;
	if(recbin != NULL) {
		qDebug() << "Ending recording";
		gst_element_set_state(recbin, GST_STATE_NULL);
		recbin = NULL;
		QMetaObject::invokeMethod(parent(), "reset", Q_RETURN_ARG(QVariant, ret));
		return;
	}
	qDebug() << "Starting recording";
	QMetaObject::invokeMethod(parent(), "setStatus", Q_RETURN_ARG(QVariant, ret), Q_ARG(QVariant, "Recording..."));
	recbin = gst_pipeline_new("pipeline");
	GError *err = NULL;
	recbin = gst_parse_launch("autoaudiosrc ! level ! tee name=t   t. ! queue ! audioconvert ! audioresample ! appsink name=asink caps=audio/x-raw-float,channels=1,rate=11025,width=32,endianness=1234  t. ! queue ! audioconvert ! monoscope ! videobalance saturation=0 ! videoflip method=6 ! ffmpegcolorspace ! xvimagesink name=overlay", &err);
	sink = gst_bin_get_by_name(GST_BIN(recbin), "asink");
	overlay = gst_bin_get_by_name(GST_BIN(recbin), "overlay");
	gst_x_overlay_set_xwindow_id(GST_X_OVERLAY(overlay), view->effectiveWinId());
	printf("Window ID: %d\n", view->effectiveWinId());
	gst_x_overlay_set_render_rectangle(GST_X_OVERLAY(overlay), 655, 140, 100, 200);
	gst_element_set_state(recbin, GST_STATE_PLAYING);
	timer->setSingleShot(true);
	timer->start(25000);
}


void Eyrie::process() {
	qDebug() << "Ending recording";
	if(recbin == NULL) {
		return;
	}
	QVariant ret;
	QMetaObject::invokeMethod(parent(), "setStatus", Q_RETURN_ARG(QVariant, ret), Q_ARG(QVariant, "Generating Echoprint Code"));
	gst_element_send_event(recbin, gst_event_new_eos());
	GstBuffer *buf = gst_buffer_new();
	GstBuffer *tmpbuf;
	bool recfailed = true;
	while(!gst_app_sink_is_eos(GST_APP_SINK(sink))) {
		tmpbuf = gst_app_sink_pull_buffer(GST_APP_SINK(sink));
		buf = gst_buffer_join(buf, tmpbuf);
		recfailed = false;
	}
	if(recfailed) {
		QMetaObject::invokeMethod(parent(), "setStatus", Q_RETURN_ARG(QVariant, ret), Q_ARG(QVariant, "Sorry, the recording failed."));
		return;
	}
	const float *pcm = (const float *) GST_BUFFER_DATA(buf);
	Codegen *codegen = new Codegen(pcm, GST_BUFFER_SIZE(buf) / sizeof(float), 0);
	std::string code = codegen->getCodeString();
	QNetworkAccessManager *networkManager = new QNetworkAccessManager();
	QUrl url("http://developer.echonest.com/api/v4/song/identify");
	QByteArray params;
	params.append("api_key=RIUKSNTIPKUMPHPEO");
	params.append("&query=[{\"metadata\":{\"version\":4.12},\"code\":\""); params.append(code.c_str()); params.append("\"}]");
	QNetworkRequest request;
	request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded;charset=UTF-8");
	request.setUrl(url);
	connect(networkManager, SIGNAL(finished(QNetworkReply *)), this, SLOT(parseResponse(QNetworkReply *)));
	networkManager->post(request, params);
	gst_element_set_state(recbin, GST_STATE_NULL);
	recbin = NULL;
	QMetaObject::invokeMethod(parent(), "setStatus", Q_RETURN_ARG(QVariant, ret), Q_ARG(QVariant, "Looking up song via EchoNest..."));
}


void Eyrie::parseResponse(QNetworkReply *reply) {
	QVariant ret;
	qDebug() << "Parsing network response";
	bool ok;
	QJson::Parser parser;
	QVariantMap result = parser.parse(reply->readAll(), &ok).toMap();
	QVariantMap response = result["response"].toMap();
	QVariantList songs = response["songs"].toList();
	if(songs.size() > 0) {
		QVariantMap song = songs[0].toMap();
		QString artist_id = song["artist_id"].toString();
		QString artist = song["artist_name"].toString().trimmed();
		QString title = song["title"].toString().trimmed();
		qDebug() << artist << title;
		QMetaObject::invokeMethod(parent(), "setDetails", Q_RETURN_ARG(QVariant, ret), Q_ARG(QVariant, artist), Q_ARG(QVariant, title));
		QNetworkAccessManager *networkManager = new QNetworkAccessManager();
		QUrl url(QString("http://developer.echonest.com/api/v4/artist/images?api_key=RIUKSNTIPKUMPHPEO&results=1&id=") + artist_id);
		QNetworkRequest request;
		request.setUrl(url);
		connect(networkManager, SIGNAL(finished(QNetworkReply *)), this, SLOT(showImage(QNetworkReply *)));
		networkManager->get(request);
	} else {
		QMetaObject::invokeMethod(parent(), "setStatus", Q_RETURN_ARG(QVariant, ret), Q_ARG(QVariant, "Sorry, we couldn't work out what\nsong that was."));
	}
	QMetaObject::invokeMethod(parent(), "resetButton", Q_RETURN_ARG(QVariant, ret));
}


void Eyrie::showImage(QNetworkReply *reply) {
	QJson::Parser parser;
	bool ok;
	QVariantMap result = parser.parse(reply->readAll(), &ok).toMap();
	QVariantMap response = result["response"].toMap();
	QVariantList images = response["images"].toList();
	if(images.size() > 0) {
		QVariantMap image = images[0].toMap();
		QString url = image["url"].toString();
		qDebug() << url;
		QVariant ret;
		QMetaObject::invokeMethod(parent(), "showImage", Q_RETURN_ARG(QVariant, ret), Q_ARG(QVariant, url));
	}
}
