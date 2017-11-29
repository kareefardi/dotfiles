#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
# >>> BEGIN ADDED BY CNCHI INSTALLER
EDITOR=/usr/bin/nano
# <<< END ADDED BY CNCHI INSTALLER

#anaconda
export PATH=/home/karim/anaconda3/bin:$PATH

# paths
mnt="/mnt/hd0"
popcorn="/home/karim/Downloads/PopCorn/Popcorn-Time"
	

# mnt
alias mnt0="sudo mount -o rw, /dev/sda7 $mnt && echo \"mounted sda7 \""
# popcorn
alias pop="$popcorn && echo \"running popcorn in background\""
