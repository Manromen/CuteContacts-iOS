#include <QApplication>
#include <QQmlApplicationEngine>
#include "ioshelper.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

#if defined(Q_OS_IOS)
    qmlRegisterType<IOSHelper>("IOSHelper", 1, 0, "IOSHelper");
#endif // Q_OS_IOS

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
