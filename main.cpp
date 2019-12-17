//#define USE_ENGINE_ 1

#include <QtQml>
#include "reader.h"
#include "finder.h"
#include <QGuiApplication>
#ifdef USE_ENGINE_
    #include <QQmlApplicationEngine>
#else
    #include <QQuickView>
#endif

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    
    QGuiApplication app(argc, argv);
    
    qmlRegisterType<Reader>("Reader", 1, 0, "Reader");
    qmlRegisterType<Finder>("Finder", 1, 0, "Finder");
    
#ifdef USE_ENGINE_
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qmls/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
#else
    QQuickView viewer;
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setSource(QUrl("qrc:/qmls/main.qml"));
    viewer.show();
#endif

    return app.exec();
}
