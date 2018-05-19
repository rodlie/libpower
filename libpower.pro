#
# Copyright (c) 2018, Ole-André Rodlie <ole.andre.rodlie@gmail.com> All rights reserved.
#
# Available under the 3-clause BSD license
# See the LICENSE file for full details
#

QT += dbus
QT -= gui
CONFIG += install_lib

TARGET = Power
VERSION = 1.0.0

TEMPLATE = lib
SOURCES += power.cpp
HEADERS += power.h upower.h powermanagement.h screensaver.h

# if embedded in lumina-extra
exists(../../lumina-extra.pri) {
    message("libpower using lumina-extra override")
    include(../../lumina-extra.pri)
}
# if embedded in qtfm
exists(../qtfm.pri) {
    message("libpower using qtfm override")
    include(../qtfm.pri)
}

CONFIG(install_lib) {
    CONFIG += create_prl no_install_prl create_pc
    isEmpty(PREFIX) {
        PREFIX = /usr/local
    }
    isEmpty(DOCDIR) {
        DOCDIR = $$PREFIX/share/doc
    }

    target.path = $${PREFIX}/lib$${LIBSUFFIX}
    target_docs.path = $${DOCDIR}/libpower-$${VERSION}
    target_docs.files = LICENSE README.md
    target_inc.path = $${PREFIX}/include/libpower
    target_inc.files = power.h powermanagement.h screensaver.h

    QMAKE_PKGCONFIG_NAME = $${TARGET}
    QMAKE_PKGCONFIG_DESCRIPTION = UPower library for Qt
    QMAKE_PKGCONFIG_LIBDIR = $$target.path
    QMAKE_PKGCONFIG_INCDIR = $$target_inc.path
    QMAKE_PKGCONFIG_DESTDIR = pkgconfig

    INSTALLS += target target_docs target_inc
}
