#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Random phrase displayed when logging into a terminal
#command cowsay $(fortune)
#fortune -a | fmt -80 -s | cowsay -$(shuf -n 1 -e b d g p s t w y) -f $(shuf -n 1 -e $(cowsay -l | tail -n +2)) -n

# Enable auto-complete after sudo and man
complete -cf sudo
complete -cf man

# Bash history completion bound to arrow keys (down, up)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

PS1='[\u@\h \W]\$ '

export EDITOR="vim"
export VISUAL=$EDITOR
#export PAGER=$EDITOR # external viewer in Midnight Commander
export BROWSER=/usr/bin/luakit
#export BROWSER=/usr/bin/firefox

# Nicer look of Java aplications
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# Coloring less command
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# XDG Base Directories
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# A simple and extensible shell script for managing your todo.txt file
alias t='todo.sh -c -d ~/.todo/config'
export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n'

# Typing tutor
alias gtypist='LC_ALL=C gtypist'

alias cdrom="sudo mount -t auto /dev/sr0 /media/cdrom0"
alias ucdrom="sudo umount /media/cdrom0"
alias cdromcrypt="sudo cryptsetup --key-file /root/.key4iso -r luksOpen /dev/sr0 cryptcd; sudo mount /dev/mapper/cryptcd /media/cryptcd/"
alias ucdromcrypt="sudo umount /dev/mapper/cryptcd; sudo dmsetup remove cryptcd"

alias lshdd="sudo lsblk -io NAME,TYPE,SIZE,MOUNTPOINT,FSTYPE,MODEL"

alias cleanconfig='sed -e '\''s/#.*//'\'' -e '\''s/[ ^I]*$//'\'' -e '\''/^$/ d'\'''

alias mount.iso="mount -t iso9660 -o loop"
alias mount.mdf="mount -o loop"
alias mount.nrg="mount -o loop,offset=307200"

# Using One Vim session
#alias g="gvim --remote-silent"
# Detect file encoding
alias vimenc='vim -c '\''let $enc = &fileencoding | execute "!echo Encoding:  $enc" | q'\'''

# Printer specific aliases
alias lpr-hp='lpr -P HP_LaserJet_3055'
alias lpr-canon='lpr -P Canon_MF5900_UFRII_LT'
alias lpr-pdf='lpr -P Virtual_PDF_Printer'
alias a2ps-pdf='a2ps --portrait --no-header --font-size=8 --columns=1 --borders=0 --printer=pdf'

# Stardict console version with history (up and down arrows)
alias def='rlwrap sdcv'

# Prevent wget creating lots of log files in home directory
#alias wget='wget -O /dev/null'

# modified commands
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 5'
alias ..='cd ..'

# new commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep $1'      # requires an argument
alias openports='netstat --all --numeric --programs --inet --inet6'
alias pg='ps -Af | grep $1'         # requires an argument (note: /usr/bin/pg is installed by the util-linux package; maybe a different alias name should be used)

# privileged access
if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudo vim'
    alias root='sudo su'
    alias reboot='sudo reboot'
    alias poweroff='sudo poweroff'
    alias halt='sudo halt'
    alias update='sudo pacman -Su'
    #alias netcfg='sudo netcfg2'
    alias netcfg='sudo netcfg'
fi

# ls
alias ls='ls -hF --color=auto'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# pacman aliases (if applicable, replace 'pacman' with your favorite AUR helper)
alias pac="pacman -S"      # default action     - install one or more packages
alias pacu="pacman -Syu"   # '[u]pdate'         - upgrade all packages to their newest version
alias pacs="pacman -Ss"    # '[s]earch'         - search for a package using one or more keywords
alias paci="pacman -Si"    # '[i]nfo'           - show information about a package
alias pacr="pacman -R"     # '[r]emove'         - uninstall one or more packages
alias pacl="pacman -Sl"    # '[l]ist'           - list all packages of a repository
alias pacll="pacman -Qqm"  # '[l]ist [l]ocal'   - list all packages which were locally installed (e.g. AUR packages)
alias paclo="pacman -Qdt"  # '[l]ist [o]rphans' - list all packages which are orphaned
alias paco="pacman -Qo"    # '[o]wner'          - determine which package owns a given file
alias pacf="pacman -Ql"    # '[f]iles'          - list all files installed by a given package
alias pacc="pacman -Sc"    # '[c]lean cache'    - delete all not currently installed package files
alias pacm="makepkg -fci"  # '[m]ake'           - make package from PKGBUILD file in current directory


# After quit from mc, shell wil automaticaly cd to same dir
alias mc=". /usr/lib/mc/mc-wrapper.sh"

# Midnight Commander Skin
export MC_SKIN=$HOME/.config/mc/skins/gotar.ini

# alias for mc to get a skin of your choice loaded instead of mc's default skin on 16-color terminal
if [[ "$TERM" = "linux" ]]; then
  myMCFallbackSkin="$HOME/.config/mc/skins/modarcon16-defbg.ini"
  alias mc="mc --skin $myMCFallbackSkin"
  alias mcedit="mcedit --skin $myMCFallbackSkin"
  alias mcview="mcview --skin $myMCFallbackSkin"
  alias mcdiff="mcdiff --skin $myMCFallbackSkin"
fi
