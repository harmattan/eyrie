TEMPLATE = app
QT += declarative
CONFIG += meegotouch
TARGET = "earie"
DEPENDPATH += .
INCLUDEPATH += .

# Input
HEADERS += earie.h
SOURCES += main.cpp \
earie.cpp
#FORMS#

  unix {
    CONFIG += link_pkgconfig
    PKGCONFIG += gstreamer-0.10
    PKGCONFIG += gstreamer-app-0.10
    #VARIABLES
    isEmpty(PREFIX) {
        PREFIX = /usr
  }

BINDIR = $$PREFIX/bin
DATADIR =$$PREFIX/share

DEFINES += DATADIR=\\\"$$DATADIR\\\" PKGDATADIR=\\\"$$PKGDATADIR\\\"

#MAKE INSTALL

INSTALLS += target qmlgui desktop service iconxpm iconScale image

  target.path =$$BINDIR

  qmlgui.path = $$DATADIR/librefm
  qmlgui.files += *.qml

  desktop.path = $$DATADIR/applications
  desktop.files += $${TARGET}.desktop

  service.path = $$DATADIR/dbus-1/services/
  service.files += com.meego.$${TARGET}.service

  iconxpm.path = $$DATADIR/pixmap
  iconxpm.files += ../data/maemo/$${TARGET}.xpm

  iconScale.path = $$DATADIR/icons/hicolor/scalable/apps
  iconScale.files += ../data/scalable/$${TARGET}.svg

  image.path = $$DATADIR/librefm
  image.files += *.png
  image.files += *.svg
}

OTHER_FILES += \
    About.qml \
    Earie.qml 
