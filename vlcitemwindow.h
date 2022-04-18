#ifndef VLCITEMWINDOW_H
#define VLCITEMWINDOW_H

#include <QQuickPaintedItem>
#include <QObject>
#include <vlc/vlc.h>
#include <QFileDialog>
#include <QQuickWindow>

#define qtu( i ) ((i).toUtf8().constData())

class VlcItemWindow : public QQuickWindow
{
    Q_OBJECT
public:
    VlcItemWindow(QWindow *parent = 0);
    ~VlcItemWindow();


public slots:
    void openFile(QString);
    void play();
    void stop();
    void mute();


    int changeVolume(int);
    void changePosition(int);


private:
    int _volume;
    libvlc_instance_t *vlcInstance;
    libvlc_media_player_t *vlcPlayer;
};

#endif // VLCITEMWINDOW_H
