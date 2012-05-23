TEMPLATE = app
QT += declarative
CONFIG += meegotouch
TARGET = "eyrie"
DEPENDPATH += .
INCLUDEPATH += . \
../../echoprint-codegen/src/

# Input
HEADERS += eyrie.h
SOURCES += main.cpp \
eyrie.cpp
#FORMS#

  unix {
    CONFIG += link_pkgconfig
    PKGCONFIG += gstreamer-0.10
    PKGCONFIG += gstreamer-app-0.10
    PKGCONFIG += QJson
    LIBS += libcodegen.so.4
    #VARIABLES
    isEmpty(PREFIX) {
        PREFIX = /opt/eyrie
  }

BINDIR = $$PREFIX/bin
DATADIR =$$PREFIX/share

DEFINES += DATADIR=\\\"$$DATADIR\\\" PKGDATADIR=\\\"$$PKGDATADIR\\\"

#MAKE INSTALL

INSTALLS += target qmlgui desktop icon image lib

  target.path =$$BINDIR

  qmlgui.path = $$DATADIR/eyrie
  qmlgui.files += *.qml

  lib.path = $$PREFIX/lib/
  lib.files += libcodegen.so.4

  desktop.path = /usr/share/applications
  desktop.files += $${TARGET}.desktop

  icon.path = /usr/share/icons/hicolor/80x80/apps
  icon.files += $${TARGET}.png

  image.path = $$DATADIR/eyrie
  image.files += *.png
}

OTHER_FILES += \
    About.qml \
    Eyrie.qml
