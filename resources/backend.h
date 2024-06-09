#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <qqml.h>
#include <QLocalSocket>
#include <QQmlPropertyMap>
#include <QJsonArray>
#include <QJsonObject>
#include <QHash>

#include <QCanBusDevice>
#include <QCanDbcFileParser>
#include <QCanFrameProcessor>
#include <QTimer>

#include <string>
#include <sstream>
#include <iostream>
#include <cmath>
#include <memory>

QT_BEGIN_NAMESPACE
class QLabel;
QT_END_NAMESPACE

struct Sensors {
    QString qmlName;
    QString dbcName;
    QString frameID;
};

class Backend : public QObject {
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);
    ~Backend();
    void processConfig();
    void parseDbcFiles();
    void openCanSocket(const QString serverName,
                       const QString interfaceName,
                       QCanBusDevice* canDevice);
    void openUnixSocket();

    QQmlPropertyMap map_name_value_; // Read configuration file for pipe or CAN

private slots:
    void processReceivedFrames();
    void processErrors(QCanBusDevice::CanBusError error) const;

signals:
    //emit which tyre and temmperature
    void tyreValueChanged(const QString& tyre, const float sensorValue);

private:
    QCanFrameProcessor frameProcessor_;
    QList<QCanBusDevice*> can_devices_;
    qint64 number_frames_received_ = 0;
    QTimer *bus_status_timer;
    static QString frameFlags(const QCanBusFrame &frame);
    QHash<QString, Sensors> sensors_struct_;
    QString error_string_;

    //config file parameters
    bool connect_;
    QJsonArray dbc_files_;
    bool using_pipe_;
    QJsonArray interfaces_;
    QJsonObject sensors_;

};

#endif // BACKEND_H
