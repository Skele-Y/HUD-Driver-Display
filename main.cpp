#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QFontDatabase>

#include "resources/backend.h"
#include  "resources/logformatter.h"
#include "resources/colourmap.h"

int main(int argc, char *argv[])
{
    // init logging
    qInstallMessageHandler(&LogFormatter::format);
    LogFormatter::init();

    QGuiApplication app(argc, argv);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QQuickView view;
    QQmlContext *ctxt = view.rootContext();
    Backend backend;
    ColourMap colourmap;
    view.setSource(url);

    QObject::connect(&backend,
                     SIGNAL(tyreValueChanged(const QString &, const float)),
                     &colourmap,
                     SLOT(onTyreValueChanged(const QString &, const float)));

    ctxt->setContextProperty("sensors", &backend.map_name_value_);
    ctxt->setContextProperty("tyreTypeColorMap", &colourmap.tyreType_color_map_);
    ctxt->setContextProperty("backend", &backend);

    QFontDatabase::addApplicationFont("qrc:/resources/Roboto-Bold.ttf");
    QFontDatabase::addApplicationFont("qrc:/resources/Roboto-Light.ttf");

    view.show();
    view.setMinimumSize(QSize(1024, 600));
    return app.exec();
}
