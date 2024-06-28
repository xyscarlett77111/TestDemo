#ifndef MAINDATAMANAGE_H
#define MAINDATAMANAGE_H

#include <QObject>
#include <QQmlEngine>
#include <QJSEngine>

class MainDataManage : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString data READ data WRITE setData NOTIFY dataChanged)

public:
    static QObject* getInstance(QQmlEngine *engine, QJSEngine *scriptEngine);

    QString data() const;
    void setData(const QString &data);

signals:
    void dataChanged();

private:
    explicit MainDataManage(QObject *parent = nullptr);
    static MainDataManage *m_instance;

    QString m_data;
};

#endif // MAINDATAMANAGE_H
