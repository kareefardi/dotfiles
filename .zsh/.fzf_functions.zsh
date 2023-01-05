
# Base16 Default Dark
# Author: Chris Kempson (http://chriskempson.com)

_gen_fzf_default_opts() {

    local color00='#1d2021'
    local color01='#282828'
    local color02='#383838'
    local color03='#585858'
    local color04='#b8b8b8'
    local color05='#d8d8d8'
    local color06='#e8e8e8'
    local color07='#f8f8f8'
    local color08='#ab4642'
    local color09='#dc9656'
    local color0A='#f7ca88'
    local color0B='#a1b56c'
    local color0C='#86c1b9'
    local color0D='#7cafc2'
    local color0E='#ba8baf'
    local color0F='#a16946'

    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS\
    --layout=reverse\
    --border --margin=0,1,0 --padding=0\
    --preview-window right,40%\
    --info=inline\
    --color=bg+:$color01,bg:$color00,border:$color04,spinner:$color0C,hl:$color0D\
    --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C\
    --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D" 

}
_gen_fzf_default_opts
#export FZF_DEFAULT_OPTS='--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1 --color=bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672'

# fd - cd to selected directory
fcd() {
    local dir
    dir=$(fdfind --type d -I -L 2> /dev/null | fzf +m) &&
        cd "$dir"
    }
# fda - including hidden directories
fda() {
    local dir
    dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}


fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && nvim "${files[@]}"
}

fdiff() {
  nvim -d $(fzf -m )
}

ff () { [[ -n $1 ]] && cd $1 # go to provided folder or noop
RG_DEFAULT_COMMAND="rg -i -l --hidden --no-ignore-vcs"

selected=$(
FZF_DEFAULT_COMMAND="rg --files" fzf \
  -m \
  -e \
  --ansi \
  --disabled \
  --reverse \
  --bind "ctrl-a:select-all" \
  --bind "f12:execute-silent:(subl -b {})" \
  --bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
  --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
)

[[ -n $selected ]] && subl $selected}

fcdf() {
    local file
    local dir
    file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# Run command/application and choose paths/files with fzf.                      
# Always return control of the terminal to user (e.g. when opening GUIs).       
# The full command that was used will appear in your history just like any      
# other (N.B. to achieve this I write the shell's active history to             
# ~/.bash_history)                                                                
#                                                                               
# Usage:
# f cd [OPTION]... (hit enter, choose path)
# f cat [OPTION]... (hit enter, choose files)
# f vim [OPTION]... (hit enter, choose files)
# f vlc [OPTION]... (hit enter, choose files)

# Use fd and fzf to get the args to a command.
# Works only with zsh
# Examples:
# f mv # To move files. You can write the destination after selecting the files.
# f 'echo Selected:'
# f 'echo Selected music:' --extension mp3
# fm rm # To rm files in current directory
f() {
    sels=( "${(@f)$(fdfind "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

# Like f, but not recursive.
fm() f "$@" --max-depth 1

# Deps
alias fz="fzf-noempty --bind 'tab:toggle,shift-tab:toggle+beginning-of-line+kill-line,ctrl-j:toggle+beginning-of-line+kill-line,ctrl-t:top' --color=light -1 -m"
fzf-noempty () {
	local in="$(</dev/stdin)"
	test -z "$in" && (
		exit 130
	) || {
		ec "$in" | fzf "$@"
	}
}
ec () {
	if [[ -n $ZSH_VERSION ]]
	then
		print -r -- "$@"
	else
		echo -E -- "$@"
	fi
}
