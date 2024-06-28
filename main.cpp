#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "KeyboardInputManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterSingletonInstance("com.example", 1, 0, "KeyboardInputManager", KeyboardInputManager::instance());

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
