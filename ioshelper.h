#ifndef IOSHELPER_H
#define IOSHELPER_H

#include <QQuickItem>

class IOSHelper : public QQuickItem
{
    Q_OBJECT
public:
    explicit IOSHelper(QQuickItem *parent = 0);

signals:

public slots:
    void makeFullscreen();

};
#endif // IOSHELPER_H
