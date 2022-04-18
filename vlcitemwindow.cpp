#include "vlcitemwindow.h"

VlcItemWindow::VlcItemWindow(QWindow *parent):QQuickWindow(parent)
{
    _volume = 80;
    vlcPlayer = NULL;
    vlcInstance = libvlc_new(0, NULL);
    setFlags( Qt::FramelessWindowHint);
}

VlcItemWindow::~VlcItemWindow()
{
    if (vlcInstance)
        libvlc_release(vlcInstance);
}

void VlcItemWindow::openFile(QString filename )
{
    /* Stop if something is playing */
    if (vlcPlayer && libvlc_media_player_is_playing(vlcPlayer))
        stop();

    /* Create a new Media */
    libvlc_media_t *vlcMedia = libvlc_media_new_path(vlcInstance, qtu(filename));
    if (!vlcMedia)
        return;

    /* Create a new libvlc player */
    vlcPlayer = libvlc_media_player_new_from_media (vlcMedia);

    /* Release the media */
    libvlc_media_release(vlcMedia);
   /* Integrate the video in the interface */

#if defined(Q_OS_MAC)
    libvlc_media_player_set_nsobject(vlcPlayer, (void *) this->winId()/* videoWidget->winId()*/);
#elif defined(Q_OS_UNIX)
    libvlc_media_player_set_xwindow(vlcPlayer, this->winId()/*videoWidget->winId()*/);
#elif defined(Q_OS_WIN)
    libvlc_media_player_set_hwnd(vlcPlayer, this->winId() /*videoWidget->winId()*/);
#endif
    /* And start playback */
    libvlc_media_player_play (vlcPlayer);

    /* Update playback button */
}



void VlcItemWindow::play() {
    if (!vlcPlayer)
        return;

    if (libvlc_media_player_is_playing(vlcPlayer))
    {
        /* Pause */
        libvlc_media_player_pause(vlcPlayer);
    }
    else
    {
        /* Play again */
        libvlc_media_player_play(vlcPlayer);
    }
}

int VlcItemWindow::changeVolume(int vol) { /* Called on volume slider change */

    if (vlcPlayer)
        return libvlc_audio_set_volume (vlcPlayer,vol);

//    return 0;
}

void VlcItemWindow::changePosition(int pos) { /* Called on position slider change */

    if (vlcPlayer)
        return libvlc_media_player_set_position(vlcPlayer, (float)pos/1000.0);
}


void VlcItemWindow::stop() {
    if(vlcPlayer) {
        /* stop the media player */
        libvlc_media_player_stop(vlcPlayer);

        /* release the media player */
        libvlc_media_player_release(vlcPlayer);

        /* Reset application values */
        vlcPlayer = NULL;
    }
}

void VlcItemWindow::mute() {
    if(vlcPlayer) {
        if(_volume == 0)
            _volume = 80;
        else
            _volume =0;
        this->changeVolume(80);
    }
}

