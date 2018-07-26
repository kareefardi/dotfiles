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

# awscli
export PATH=/home/karim/.local/bin:$PATH

# paths
mnt0="/mnt/hd0"
mnt1="/mnt/hd1"
popcorn="/home/karim/Downloads/PopCorn/Popcorn-Time"
auc="/mnt/hd0/AUC/FALL17"
	

# mnt
alias mnt0="sudo mount -o rw, /dev/sda7 $mnt0 && echo \"mounted sda7 \""
alias mnt1="sudo mount -o rw, /dev/sda4 $mnt1 && echo \"mounted sda4 \""
# popcorn
alias pop="$popcorn && echo \"running popcorn in background\""
# auc
alias auc="cd $auc && echo \"auc folder\""

alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias bright="sudo tee /sys/class/backlight/intel_backlight/brightness <<< "

alias steam="steam > ~/.steam_log.txt & echo \"running steam in background (log in home steam_log)\""
