#include "SerialPortHandler.h"
#include <QDebug>

SerialPortHandler::SerialPortHandler(QObject *parent)
    : QObject(parent), m_isSerialPortOpen(false)
{
    connect(&serialPort, &QSerialPort::readyRead, this, &SerialPortHandler::readData);
}

SerialPortHandler::~SerialPortHandler() {
    if (serialPort.isOpen()) {
        serialPort.close();
    }
}

void SerialPortHandler::openSerialPort(const QString &portName) {
    if (serialPort.isOpen()) {
        serialPort.close();
    }

    serialPort.setPortName(portName);
    if (serialPort.open(QIODevice::ReadWrite)) {
        m_isSerialPortOpen = true;
        emit serialPortOpened();
        emit serialPortOpenChanged();
        qDebug() << "Serial port opened:" << portName;
    } else {
        qDebug() << "Failed to open serial port:" << portName;
    }
}

void SerialPortHandler::closeSerialPort() {
    if (serialPort.isOpen()) {
        serialPort.close();
        m_isSerialPortOpen = false;
        emit serialPortOpenChanged();
        qDebug() << "Serial port closed";
    }
}

QStringList SerialPortHandler::getAvailablePorts() const {
    QStringList portList;
    const auto infos = QSerialPortInfo::availablePorts();
    for (const QSerialPortInfo &info : infos) {
        portList << info.portName();
    }
    return portList;
}

bool SerialPortHandler::isSerialPortOpen() const {
    return m_isSerialPortOpen;
}

void SerialPortHandler::readData() {
    const QByteArray data = serialPort.readAll();
    emit dataReceived(QString::fromUtf8(data));
}

void SerialPortHandler::sendData(const QString &data) {
    if (serialPort.isOpen()) {
        serialPort.write(data.toUtf8());
    }
}
