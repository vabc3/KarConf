#!/bin/sh
command=compiz-manager
#command=openbox-session

userresources=$HOME/.Xresources
usermodmap=$HOME/.xmodmap
userbindkey=$HOME/.xbindkeysrc

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -f "$userbindkey" ]; then
    xbindkeys
fi


if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f

fi

export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx

tint2 &

exec $command

