#include "KeyboardInputManager.h"
#include <QGuiApplication>
#include <QKeyEvent>

KeyboardInputManager::KeyboardInputManager()
{
    // Install an event filter to capture keyboard events
    QGuiApplication::instance()->installEventFilter(this);
}

KeyboardInputManager::~KeyboardInputManager() {}

bool KeyboardInputManager::eventFilter(QObject *obj, QEvent *event)
{
    if (event->type() == QEvent::KeyPress) {
        QKeyEvent *keyEvent = static_cast<QKeyEvent *>(event);
        emit keyPressed(keyEvent->text());
        return true;
    } else {
        return QObject::eventFilter(obj, event);
    }
}

