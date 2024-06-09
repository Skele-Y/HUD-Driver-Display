#include <QtLogging>
#include <stdio.h>
#include <stdlib.h>
#include <QRegularExpression>
#include <QDir>


#ifndef LOGFORMATTER_H
#define LOGFORMATTER_H


class LogFormatter
{
public:
    inline static QDateTime INIT_TIME = QDateTime();
    static void format(QtMsgType type, const QMessageLogContext &context, const QString &msg);
    static void init();
private:
    LogFormatter(){};
};

#endif // LOGFORMATTER_H
