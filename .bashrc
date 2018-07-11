# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend
HISTCONTROL=ignoreboth # ignorespace:ignoredups but do not erasedups
export HISTFILESIZE=500000 HISTSIZE=500000

export MANWIDTH=100
export VIM='/usr/share/vim'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# globstar enables path expansion for:
# **
#        Match all files, directories, and subdirectories.
shopt -s globstar

# extglob enables path expansion for:
# ?(pattern-list)
#        Matches zero or one occurrence of the given patterns
# *(pattern-list)
#        Matches zero or more occurrences of the given patterns
# +(pattern-list)
#        Matches one or more occurrences of the given patterns
# @(pattern-list)
#        Matches one of the given patterns
# !(pattern-list)
#        Matches anything except one of the given patterns
shopt -s extglob

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f ~/.phpbrew/bashrc ]; then
	source ~/.phpbrew/bashrc
fi

if [ -d "$HOME/.nvm" ]; then
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi


