#ifndef KEYBOARDINPUTMANAGER_H
#define KEYBOARDINPUTMANAGER_H

#include <QObject>

class KeyboardInputManager : public QObject
{
    Q_OBJECT
public:
    static KeyboardInputManager* instance()
    {
        static KeyboardInputManager instance;
        return &instance;
    }

signals:
    void keyPressed(const QString &key);

protected:
    bool eventFilter(QObject *obj, QEvent *event) override;

private:
    KeyboardInputManager(); // 私有构造函数，确保不会从外部创建类的实例
    ~KeyboardInputManager();
    KeyboardInputManager(const KeyboardInputManager&) = delete;
    KeyboardInputManager& operator=(const KeyboardInputManager&) = delete;
};

#endif // KEYBOARDINPUTMANAGER_H
