#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# for a colorful rxvt unicode session
export TERM=rxvt-unicode-256color

# Switching Caps-Lock and Escape with xmodmap
setxkbmap -option caps:escape

# Отключение энергосбережения
xset s off -dpms

# Disable PC Speaker Beep
xset -b

[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

# Compositing window manager
compton -cCGfF -b -i 0.75 --vsync opengl

# ... the Window Manager of your choice
# exec gnome-session
# exec startkde
# exec startxfce4
# exec startfluxbox
exec i3
