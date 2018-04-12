
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\$ '

    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias d='drush -y'
alias ag='drush @ag -y'
alias gw='drush @gw -y'
alias tail='grc tail'
alias patchclean='find . \( -name \*.orig -o -name \*.rej \) -delete'
alias whatup='multitail -R 2 -l "netstat -tp | grep ESTABLISHED"'
alias pscan='nmap -v -sT'
alias memcachestat='watch "echo stats | nc 127.0.0.1 11211"'
alias irc='ssh -t syd.webzen.com.au screen -R -d'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias err='tail -f /var/log/apache2/error.log'

# Docker aliases
alias dps='docker ps'
alias d='docker'
alias di='docker images'
alias drm='docker rm -f'
alias drmc='docker rm -v -f $(docker ps -a -q -f status=exited)'
alias drmi='docker rmi -f $(docker images -a -q)'
#alias drma='docker rm -v $(docker ps -a -q)'
alias dsa='docker stop $(docker ps -aq)'

# Docker compose aliases
alias dcr='docker-compose run --rm '
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcb='docker-compose build'

# git aliases
alias patchclean='find . \( -name \*.orig -o -name \*.rej \) -delete'


# autojump woo.
if [ -f /usr/share/autojump/autojump.bash ]; then
  source /usr/share/autojump/autojump.bash
fi

# Git
source ~/.git-completion.sh
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

# Stop CTRL-S sending XOFF.
stty ixany
stty ixoff -ixon

# SQLplus is a lame duck cli tool. at least make it wrap and have history :/
sqlpluss() {
 LD_LIBRARY_PATH='' 
 rlwrap /opt/instantclient/sqlplus $1
}

# Android SDK
export PATH=${PATH}:/home/sam/src/android-sdk/platform-tools:/home/sam/src/android-sdk/tools

# Nextcloud client needs XDG_RUNTIME_DIR to be set in order for nautilus integration to work.
if test -z "${XDG_RUNTIME_DIR}"; then
export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
if ! test -d "${XDG_RUNTIME_DIR}"; then
mkdir "${XDG_RUNTIME_DIR}"
chmod 0700 "${XDG_RUNTIME_DIR}"
fi
fi

# NVM, node installer.
export NVM_DIR="/home/sam/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# NodeJS
export PATH=$HOME/.node/bin:$PATH
export NODE_PATH=$NODE_PATH:/home/sam/.node/lib/node_modules

# Drush
if [ -x drush ]; then
  # Include Drush prompt customizations.
  . $HOME/.drush/drush.prompt.sh
  # Include Drush completion.
  . $HOME/.drush/drush.complete.sh
  # Include Drush bash customizations.
  . $HOME/.drush/drush.bashrc
fi

# PHP Composer
export PATH="$HOME/.composer/vendor/bin:$PATH"
