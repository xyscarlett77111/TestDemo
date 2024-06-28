#include "maindatamanage.h"

MainDataManage* MainDataManage::m_instance = nullptr;

MainDataManage::MainDataManage(QObject *parent) : QObject(parent)
{
}

QObject* MainDataManage::getInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    if (!m_instance) {
        m_instance = new MainDataManage();
    }

    return m_instance;
}

QString MainDataManage::data() const
{
    return m_data;
}

void MainDataManage::setData(const QString &data)
{
    if (m_data != data) {
        m_data = data;
        emit dataChanged();
    }
}

