#ifndef COLOURMAP_H
#define COLOURMAP_H

#include <QObject>
#include <qqml.h>
#include <QQmlPropertyMap>
#include <QDebug>
#include <QImage>
#include <QColor>
#include <QVector>
#include <QQmlEngine>
#include <QQmlComponent>

class ColourMap: public QObject {
    Q_OBJECT
public:
    explicit ColourMap(QObject *parent = nullptr);
    QQmlPropertyMap temp_color_map_;
    QQmlPropertyMap temp_color_hex_map_;
    QQmlPropertyMap tyreType_color_map_;
public slots:
    void onTyreValueChanged(const QString& tyre, const float sensorValue);

private:
    void readImage();


};

#endif // COLOURMAP_H
