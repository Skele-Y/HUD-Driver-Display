#include "colourmap.h"


#include <QQmlProperty>

ColourMap::ColourMap(QObject *parent) : QObject(parent) {
    qInfo() << "Colour Map Object Created";
    tyreType_color_map_.insert("TyreIndicatorFL","#000000");
    tyreType_color_map_.insert("TyreIndicatorFR","#000000");
    tyreType_color_map_.insert("TyreIndicatorRL","#000000");
    tyreType_color_map_.insert("TyreIndicatorRR","#000000");
    readImage();
}

void ColourMap::readImage() {
    //load gradient image
        qDebug() << "Loading tyre temperature gradient";


        QString url;
        url = ":/resources/images/gradient.png";

        QImage gradientImg;
        if (!gradientImg.load(url)) {
            qDebug() << "Gradient failed to load";
        }
        qDebug() << "Tyre Temp gradient successfully loaded.";

        //loop and get each QColor and put into Vector
        for (int x {0}; x < 100; x++) {
            int y = 0;
            QColor rgbPix = gradientImg.pixelColor(x,y);//.name();
            QString xStr = QString::number(x);
            temp_color_map_.insert(xStr,rgbPix);
            //qDebug() << "x value is: " << xStr << " Color is: " << rgbPix;
        }
        return;
}

void ColourMap::onTyreValueChanged(const QString& tyre, const float sensorValue) {
    QString tempValue = QString::number(static_cast<int>(sensorValue));
    tyreType_color_map_.insert(tyre, temp_color_map_.value(tempValue));
    qDebug() << "COLOURMAP.CPP: signal Recieved, tyre = " << tyre << "  and sensorValue = " << tempValue;
}
