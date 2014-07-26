#include "ioshelper.h"

#if defined(Q_OS_IOS)
#import <UIKit/UIKit.h>
#endif

#include <QtGui>
#include <QtQuick>
#include <qpa/qplatformnativeinterface.h>

IOSHelper::IOSHelper(QQuickItem *parent) :
    QQuickItem(parent)
{
}

void IOSHelper::makeFullscreen()
{
#if defined(Q_OS_IOS)
    qDebug() << "make app fullscreen";

    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
       // iOS 7 or later
        UIView *view = static_cast<UIView*>(QGuiApplication::platformNativeInterface()->nativeResourceForWindow("uiview", window()));
        UIViewController *qtController = [[view window] rootViewController];

        if (qtController.view.subviews.count > 0) {
            UIView *v = qtController.view.subviews[0];

            qDebug() << "view.origin.x: " << v.frame.origin.x;
            qDebug() << "view.origin.y: " << v.frame.origin.y;
            qDebug() << "view.size.width: " << v.frame.size.width;
            qDebug() << "view.size.height: " << v.frame.size.height;

            // try to set new position and size
            CGRect newFrame = v.frame;
            newFrame.origin.y = 0;
            newFrame.size.height = v.bounds.size.height + 20;
            v.frame = newFrame;
        }
    }
#endif // Q_OS_IOS
}
