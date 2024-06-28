#ifndef SERIALPORTHANDLER_H
#define SERIALPORTHANDLER_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QQmlEngine>
#include <QJSEngine>

class SerialPortHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isSerialPortOpen READ isSerialPortOpen NOTIFY serialPortOpenChanged)

public:
    static SerialPortHandler* getInstance() {
        static SerialPortHandler instance;
        return &instance;
    }

    explicit SerialPortHandler(QObject *parent = nullptr);
    ~SerialPortHandler();

    Q_INVOKABLE void openSerialPort(const QString &portName);
    Q_INVOKABLE void closeSerialPort();
    Q_INVOKABLE QStringList getAvailablePorts() const;

    bool isSerialPortOpen() const;

signals:
    void serialPortOpened();
    void serialPortOpenChanged();
    void dataReceived(const QString &data);

private slots:
    void readData();

public slots:
    void sendData(const QString &data);

private:
    QSerialPort serialPort;
    bool m_isSerialPortOpen;

    Q_DISABLE_COPY(SerialPortHandler)
};

static QObject* SerialPortHandlerGetInstance(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return SerialPortHandler::getInstance();
}

#endif // SERIALPORTHANDLER_H
