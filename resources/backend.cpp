#include "backend.h"
#include <QDataStream>
#include <QFile>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonDocument>

#include <QCanBus>

#include <QCanUniqueIdDescription>
#include <QCanMessageDescription>


using namespace Qt::StringLiterals;


Backend::Backend(QObject *parent) : QObject(parent) {
    qInfo() << "Creating Backend Object";
    bus_status_timer = new QTimer;
    //Read through config file
    processConfig();


    //! [Open Socket]
    if (using_pipe_)
        openUnixSocket();


    else {
        // For every can_device in config make a new socket
        // Pass in new can_device to function
        //! [Put interfaces Json into variables]
        QString serverName;
        QString interfaceName;

        int i = 0;

        for (const QJsonValue &jsonValue : interfaces_) {
            if (jsonValue.isObject()) {
                // Access individual objects in the array
                QJsonObject jsonObject = jsonValue.toObject();

                // Iterate through key-value pairs of the object
                for (auto it = jsonObject.begin(); it != jsonObject.end(); ++it) {
                    serverName = it.key();
                    interfaceName = it.value().toString();
                    qDebug() << "serverName: " << serverName << " interfaceName: "<< interfaceName;
                    QCanBusDevice* rawDevice = QCanBus::instance()->createDevice(serverName, interfaceName, &error_string_);
                    can_devices_.append(rawDevice);

                    //open socket
                    openCanSocket(serverName, interfaceName, can_devices_.at(i));
                    i++;
                }
            }
        }


    }

    // initialise dbc
    parseDbcFiles();


    //signal is the invidial sensors in a can frame
        //define payload endiant type, start bit, bit length
    // Message desciptio is payload size, list of signal descriptions and unique id


//    //TESTING that dbc can decode a frame
//    QCanBusFrame frameEncoded;
//    QCanBusFrame framePrepared;

//    quint32 idEncoded = 0x705;
//    frameEncoded.setFrameId(idEncoded);
//    qDebug() << "id Frame : " << frameEncoded.frameId();

//    char data[8] = {0x00,0x61,0x00,0x61,0x00,0x61,0x00,0x61}; // 640km/h * 10
//    frameEncoded.setPayload(QByteArray::fromRawData(data, 8));
//    qDebug()<< "is frame valid : " << frameEncoded.isValid();
//    qDebug() << frameEncoded.toString();
//    qDebug() << static_cast<QString>(frameEncoded.payload());

//    QCanFrameProcessor::ParseResult result = frameProcessor.parseFrame(frameEncoded);

//    QString wsrr = "WheelSpeedRR";

//    QVariantMap &signalValue = result.signalValues;
//    QVariant qVarValue = signalValue.value(wsrr);

//    // Check if the key exists
//    if (!qVarValue.isNull()) {
//        // Print the extracted value
//        qDebug() << "Value for key" << wsrr << ":" << qVarValue;
//    }

//    if (qVarValue.canConvert<double>()) {
//         double doubleValue = qVarValue.value<double>();
//        qDebug() << "Double Value:" << doubleValue;
//    }
//    else {
//        qDebug() << "Conversion to double failed.";
//    }

//    for(QVariantMap::const_iterator iter = result.signalValues.begin(); iter != result.signalValues.end(); ++iter) {
//        qDebug() << "Key:" << iter.key() << "Type:" << iter.value().typeName() << "Value:" << iter.value();
//    }


}

Backend::~Backend() {
    // Clean up allocated resources...
    for (QCanBusDevice* device : can_devices_) {
        delete device;
    }
    delete bus_status_timer;
}

void Backend::openCanSocket(const QString serverName, const QString interfaceName,
                            QCanBusDevice* canDevice) {


    //! [create_can_device]
    if (!canDevice) {
        qDebug() << "Error creating can_device. Reason: " << error_string_;
        return;
    }

    //! [Set up signal and slots for recieving frames]
    connect(canDevice, &QCanBusDevice::errorOccurred,
            this, &Backend::processErrors);
    connect(canDevice, &QCanBusDevice::framesReceived,
            this, &Backend::processReceivedFrames);

    // Conect to device
    // if can't connect do error
    if (!canDevice->connectDevice()) {
        qDebug() << ("Connection error: ") << error_string_;
        canDevice = nullptr;
        for (QCanBusDevice* device : can_devices_) {
            delete device;
            return;
        }


    }
    else {
        // Set bitrate to 1Mbps
        // only bitratekey works with socketcan
        canDevice->setConfigurationParameter(QCanBusDevice::BitRateKey, 1000000);

        const QVariant bitRate = canDevice->configurationParameter(QCanBusDevice::BitRateKey);
        if (bitRate.isValid()) {
            const bool isCanFd = canDevice->configurationParameter(QCanBusDevice::CanFdKey).toBool();
            const QVariant dataBitRate = canDevice->configurationParameter(QCanBusDevice::DataBitRateKey);
            if (isCanFd && dataBitRate.isValid()) {
                qDebug() << "Plugin:" << serverName << ", connected to " << interfaceName <<
                            " at " << bitRate.toInt() / 1000 << " / " << (dataBitRate.toInt() / 1000) << "kBit/s";
            }
            else {
                qDebug() << "Plugin:" << serverName << ", connected to " <<
                            interfaceName << " at " << bitRate.toInt() / 1000 << "kBit/s";
            }
        }
        // if bitrate invalid
        else {
            qDebug() << "Plugin:" << serverName << ", connected to " << interfaceName;
        }

        if (canDevice->hasBusStatus())
            bus_status_timer->start(2000);
        else
            qDebug() << "No CAN bus status available.";
    }

    return;
}

 // TODO: Implement Unix Pipe emulation
void Backend::openUnixSocket() {
    QLocalSocket canSocket;
    qDebug() << "CanSocket Test Mode On: Using pipe";
    return;
}

void Backend::processConfig() {
    QFile file("config/config.json");
    if(!file.open(QFile::ReadOnly)) {
        qCritical() << "Cannot open config file";
        return;
    }
    // read the boolean for connect
    QJsonDocument config = QJsonDocument::fromJson(file.readAll());
    QJsonObject json = config.object();
    connect_ = json.value("connect").toBool();
    using_pipe_ = json.value("usingPipe").toBool();
    dbc_files_ = json.value("dbcFiles").toArray();
    sensors_ = json.value("sensors").toObject();
    interfaces_ = json.value("interfaces").toArray();
    if (sensors_.isEmpty() || interfaces_.isEmpty()) {
        qWarning() << "Empty list from config, check config for errors!";
    }

    file.close();

    // Iterate through the key-value pairs in the "sensors" object and put into QHash of structs
    // Value of sensorsObj is key of QHash
    // struct of sensorsStruct is value of QHash
    // Iterate through the key-value pairs in the "sensors" object
    for (auto it = sensors_.constBegin(); it != sensors_.constEnd(); ++it) {
        QString key = it.key();
        QJsonArray valueArray = it.value().toArray();
        if (valueArray.size() >= 2) {
            // Extract the ID and name from the array
            int id = valueArray[0].toInt();
            QString name = valueArray[1].toString();

            // Create a Sensors struct and insert it into the QHash
            Sensors sensorsStruct;
            sensorsStruct.qmlName = key;
            sensorsStruct.dbcName = name;
            sensorsStruct.frameID = QString::number(id);

            sensors_struct_.insert(key, sensorsStruct);
        }
    }

    // Print the contents of the QHash
    for (auto it = sensors_struct_.constBegin(); it != sensors_struct_.constEnd(); ++it) {
        qDebug() << "Key:" << it.key()
                 << ", QML Name:" << it.value().qmlName
                 << ", DBC Name:" << it.value().dbcName
                 << ", Frame ID:" << it.value().frameID;
    }

}

void Backend::parseDbcFiles() {
    
    QList<QCanMessageDescription> desscs;
    QCanUniqueIdDescription idDes;

    for (const auto& dbcFileVariant : dbc_files_) {
        QCanDbcFileParser dbcParser;
        const QString dbcFile = dbcFileVariant.toString();
        QString dbcFilePath = "config/" + dbcFile;
        
        if (dbcParser.parse(dbcFilePath))
            qDebug() << "DBC file " << dbcFile << " parsed successfully.";
        else
            qWarning() << "Failed to parse DBC file " << dbcFile;

    //    qDebug() << dbcParser.messageDescriptions();
        qDebug() << "idDes validity : " << dbcParser.uniqueIdDescription().isValid();
        qDebug() << "idDes endianness : " << dbcParser.uniqueIdDescription().endian();
        qDebug() << "idDes source : " << dbcParser.uniqueIdDescription().source();
        qDebug() << "idDes bit length : " << dbcParser.uniqueIdDescription().bitLength();
        qDebug() << "idDes bit start : " << dbcParser.uniqueIdDescription().startBit();

        QtCanBus::UniqueId uId;
        quint32 iId;
        foreach (auto md, dbcParser.messageDescriptions()) {
            //iId = static_cast<quint32>(md.uniqueId());
            //uId = static_cast<QtCanBus::UniqueId>(iId);
            //md.setUniqueId(uId);
            desscs.append(md);
        }
        frameProcessor_.setUniqueIdDescription(dbcParser.uniqueIdDescription());
        //frameProcessor_.setMessageDescriptions(dbcParser.messageDescriptions());
    }
    
//    frameProcessor_.setUniqueIdDescription(idDes);
    frameProcessor_.setMessageDescriptions(desscs);
    
    //make a frame processor
//    frameProcessor_.setUniqueIdDescription(dbcParser.uniqueIdDescription());
//    frameProcessor_.setMessageDescriptions(dbcParser.messageDescriptions());
}

void Backend::processReceivedFrames() {
    // Check which can bus
    QCanBusDevice* canDevice;
    for (QCanBusDevice* bus: can_devices_) {
        if (bus->framesAvailable()){
            //qDebug() << "Frame avaliable from" << bus->deviceInfo().name();
            canDevice = bus;
        }
    }
    if (!canDevice) {
        qDebug() << "Recieved Frame but no canDevice? (This is impossible)";
        return;
    }

//! [receive_can_frame]
    while (canDevice->framesAvailable()) {
        number_frames_received_++;
        const QCanBusFrame frame = canDevice->readFrame();
        QCanFrameProcessor::ParseResult result = frameProcessor_.parseFrame(frame);
        QVariantMap &signalValues = result.signalValues;
//        qDebug() << "Entire Frame: "<<frame.toString();
//        qDebug() << "Frame Type: " << frame.frameType();
//        qDebug() << "Extended Frame: " << frame.hasExtendedFrameFormat();
//        qDebug() << "Payload: " << frame.payload();
//        QString bin;
//        for (char byte: frame.payload()) {
//            for (int i =7;i>=0;--i) {
//                QString bit = QString::number((byte >> i) & 1);
//                bin.append(bit);
//            }
//        }
//        qDebug() << "Binary payload: " << bin;
//        QByteArray last = frame.payload().right(2);
//        qint64 decimal = 0;
//        QDataStream stream(last);
//        stream >> decimal;
//        qDebug() << "Last two bytes of payload: " << decimal;


        // Given the frame extract the ID
        QtCanBus::UniqueId frameuid = result.uniqueId;
//        qDebug() << "wanted frameid: " << frameuid;
        QString frameid = QString::number(static_cast<quint64>(frameuid));

        // Maintain a list of sensors so that it can be check for
        // each signal in the frame
        QList<Sensors> currentSignals;

        // Check if the id is used by frontend
        QHash<QString, Sensors>::const_iterator it;
        bool exists = false;
        for (it = sensors_struct_.constBegin(); it != sensors_struct_.constEnd(); ++it) {
            const Sensors& sensor = it.value();
//            qDebug() << "dbc name: " << sensor.dbcName
//                     << "qml name: " << sensor.qmlName
//                     << "frameID name: " << sensor.frameID;
            if (sensor.frameID == frameid) {
                exists = true;
                currentSignals.append(sensor);
            }
        }
        if (!exists) continue;

        // For each signal in the frame searching from left to right (little endian)
        for (QVariantMap::const_iterator it = signalValues.constBegin(); it != signalValues.constEnd(); ++it) {
            //qDebug() << "searching Key:" << it.key() << ", Value:" << it.value();
            double signalValue = it.value().toDouble();
            // Skip if null
            if (signalValue == 0xFFF)
                continue;

            // Otherwise if the name of that signal equals a sensor dbcName
            // in the currentSignal list
            // Send value to the qml map
            else {

                //! [Special Case Tyre Temp]
                if (currentSignals.at(0).qmlName.contains("TyreIndicator")) {
                    qDebug() << "Recieved Tyre Temperature";
                    emit tyreValueChanged(currentSignals.at(0).qmlName,
                                          signalValue);
                }


                //! [Find the correct signal name and send to qml]
                for (const auto& itSensor : currentSignals) {
                    if (itSensor.dbcName == it.key()) {
//                        qDebug() << "Sending " << itSensor.qmlName
//                                 << " as: " << QString::number(signalValue);
                        map_name_value_.insert(itSensor.qmlName,
                                               signalValue);
                    }
                }
            }
        }
    }
    return;
}


void Backend::processErrors(QCanBusDevice::CanBusError error) const
{
    switch (error) {
    case QCanBusDevice::ReadError:
    case QCanBusDevice::WriteError:
    case QCanBusDevice::ConnectionError:
    case QCanBusDevice::ConfigurationError:
    case QCanBusDevice::UnknownError:
        qWarning() << "QCanBusDevice Error: " << error_string_;
        break;
    default:
        break;
    }
}

QString Backend::frameFlags(const QCanBusFrame &frame)
{
    QString result = u" --- "_s;

    if (frame.hasBitrateSwitch())
        result[1] = u'B';
    if (frame.hasErrorStateIndicator())
        result[2] = u'E';
    if (frame.hasLocalEcho())
        result[3] = u'L';

    return result;
}
