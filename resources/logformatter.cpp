#include "logformatter.h"

#define MAX_LOG_COUNT 10

const QString ANSI_ORANGE = "\e[38;5;208m";
const QString ANSI_LIGHT_GREY = "\e[37m";
const QString ANSI_GREY = "\e[38;5;243m";
const QString ANSI_RED = "\e[0;31m";
const QString ANSI_RED_BG = "\e[41m";
const QString ANSI_PURPLE = "\e[0;35m";
const QString ANSI_RESET = "\e[0;34m";

const QString LOG_PATH = "logs/";



void LogFormatter::init(){
    LogFormatter::INIT_TIME = QDateTime::currentDateTime();

    if (!QDir().exists(LOG_PATH)) {
        qWarning() << "Log directory does not exist. Creating now.";
        if (!QDir().mkpath(LOG_PATH)){
            qCritical() << "Could not create log directory.";
        }
    };

    QDir log_dir = QDir(LOG_PATH);
    QStringList logs = log_dir.entryList(QDir::Files);

    // Delete old log files
    if(logs.size() >= MAX_LOG_COUNT){
        // Sort files by creation date
        std::sort(logs.begin(), logs.end(), [](const QString &a, const QString &b) {
            return a < b;
        });

        // Delete the oldest logs
        int filesToDelete = qMax(0, (logs.size() - MAX_LOG_COUNT) + 1);
        for (int i = 0; i < filesToDelete; ++i) {
            if (!QFile::remove(log_dir.filePath(logs[i]))) {
                qWarning() << "Failed to remove log:" << logs[i];
            }
        }
    }
}

void LogFormatter::format(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    QByteArray localMsg = msg.toLocal8Bit();
    QString log_message = QString();

    QString timestamp = QDateTime().currentDateTime().toString("dd-MM-yyyy hh:mm:ss");

    // Append timestamp to str
    log_message.append(QString("%1%2 ").arg(ANSI_PURPLE, timestamp));

    // Add debug level to str
    switch (type) {
    case QtDebugMsg:
        log_message.append(QString("%1[DEBUG]: %2").arg(ANSI_GREY, localMsg.constData()));
        break;
    case QtInfoMsg:
        log_message.append(QString("%1[INFO]: %2").arg(ANSI_LIGHT_GREY, localMsg.constData()));
        break;
    case QtWarningMsg:
        log_message.append(QString("%1[WARNING]: %2").arg(ANSI_ORANGE, localMsg.constData()));
        break;
    case QtCriticalMsg:
        log_message.append(QString("%1[CRITICAL]: %2").arg(ANSI_RED, localMsg.constData()));
        break;
    case QtFatalMsg:
        log_message.append(QString("%1[FATAL]: %2").arg(ANSI_RED_BG, localMsg.constData()));
        break;
    }

    // Print to stderr
    fprintf(stderr, "%s%s\n", log_message.toUtf8().data(), ANSI_RESET.toUtf8().data());

    // Log to file
    if(!LogFormatter::INIT_TIME.isValid()){
        qCritical() << "Cannot write to log file. Did you run LogFormatter::init()?";
        return;
    }
    QFile file(QString(LOG_PATH + "%1.log").arg(LogFormatter::INIT_TIME.toString("dd-MM-yyyy_hh-mm-ss")));
    if (!file.open(QIODevice::WriteOnly | QIODevice::Append)) {
        qCritical() << "Could not open log file.";
        return;
    };
    QTextStream textStream(&file);
    static QRegularExpression regexp("\e[\[\\d\\w;]*m");
    log_message.replace(regexp, "");
    textStream << log_message << Qt::endl;
}
