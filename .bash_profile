#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

## Restore ALSA Mixer settings at login
alsactl -f ~/.asound.state restore

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd

# The Solarized color theme
eval `dircolors ~/.dircolors.ansi-universal`

# Start X at Login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# Start fbterm at Login on tty2
[[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && exec ~/bin/fbterm-bi ~/Pictures/backgrounds/city_night_lights_bokeh-wallpaper-1280x1024.jpg

# Start fbterm at Login on tty3
[[ -z $DISPLAY && $XDG_VTNR -eq 3 ]] && exec ~/bin/fbterm-bi ~/Pictures/backgrounds/ladybug_on_white_flower-wallpaper-1280x1024.jpg

# Start fbterm at Login on tty4
[[ -z $DISPLAY && $XDG_VTNR -eq 4 ]] && exec ~/bin/fbterm-bi ~/Pictures/backgrounds/bokeh_lights_3-wallpaper-1280x1024.jpg

# Start fbterm at Login on tty5
[[ -z $DISPLAY && $XDG_VTNR -eq 5 ]] && exec ~/bin/fbterm-bi ~/Pictures/backgrounds/nightfall_4-wallpaper-1280x1024.jpg

# Start fbterm at Login on tty6
[[ -z $DISPLAY && $XDG_VTNR -eq 6 ]] && exec ~/bin/fbterm-bi ~/Pictures/backgrounds/nightfall_skyline-wallpaper-1280x1024.jpg

# Start screen at Login on tty9
[[ -z $DISPLAY && $XDG_VTNR -eq 9 ]] && exec /usr/bin/screen

#SSH Agent Startup Modified from: http://mah.everybody.org/docs/ssh#run-ssh-agent
SSH_ENV="${HOME}/.ssh/environment"
start_agent() {
  echo "Initialising new SSH agent..."
  if [ ! -d ${HOME}/.ssh ] ;then
    mkdir -p ${HOME}/.ssh
    chmod 700 ${HOME}/.ssh
    touch ${SSH_ENV}
  fi
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' >"${SSH_ENV}"
  rval=${?}
  if [ ${rval} = 0 ] ;then
    echo "Succeeded!"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" >/dev/null
    /usr/bin/ssh-add
  else
    echo "Failed to write ${SSH_ENV}"
  fi
}
# Source SSH settings, if applicable
if [ "$(tty)" != '/dev/console' ] ;then
  if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" >/dev/null
    if ! ssh-add -l | egrep '.ssh/id(entity|_dsa|_rsa)' >/dev/null ;then
      if ps -fp ${SSH_AGENT_PID} | grep ssh-agent$ >/dev/null ;then
        /usr/bin/ssh-add
      else
        start_agent
      fi
    fi
  else
    start_agent
  fi
fi
