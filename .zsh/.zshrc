# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/$USER/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	#auto-color-ls
	bgnotify
	forgit
	fzf
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-z
	zsh-expand
	zsh-vi-mode
    exa
    #zsh-autocomplete
    git-tree-zsh
	fzf-tab
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias lc='colorls'
bgnotify_threshold=3

# autosuggest bindings
unsetopt share_history

export PATH=/home/karim/.local/magic/bin:/home/karim/.local/sta/bin:$PATH:/home/karim/.local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/Downloads/or-tools_cpp_Ubuntu-20.04-64bit_v9.4.1874/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Downloads/or-tools_cpp_Ubuntu-20.04-64bit_v9.4.1874/lib
export EDITOR='nvim'
export VISUAL='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zstyle ':autocomplete:*' fzf-completion yes

source $HOME/.fzf_functions.zsh
source $HOME/.fzf-z_config.zsh
source $HOME/.ranger-function.bash

setopt no_nomatch

#my-expand() BUFFER=${(e)BUFFER} CURSOR=$#BUFFER
#zle -N my-expand

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
	bindkey '^ ' autosuggest-accept
	bindkey '^[ ' my-expand
	bindkey "^[[A" up-line-or-beginning-search # Up
	bindkey "^[[B" down-line-or-beginning-search # Down
    enable-fzf-tab
}

source $HOME/.nnn_config
source $HOME/.zsh_func
source $HOME/.oh-my-zsh/custom/plugins/zsh-histdb/sqlite-history.zsh
source $HOME/.oh-my-zsh/custom/plugins/fuzzy-fs/fuzzy-fs
autoload -Uz add-zsh-hook
export BAT_THEME=gruvbox-dark

export PATH="/home/karim/repos/git-fuzzy/bin:$PATH"
export PATH="$HOME/.local/share/nvim/lsp_servers/verible/verible/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"

# depends on terminal mode

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval $(thefuck --alias)
source $HOME/.config/lf/lfcd.sh
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
source ~/.fzf-tab-previews.zsh
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
	[[ -s /home/karim/.autojump/etc/profile.d/autojump.sh ]] && source /home/karim/.autojump/etc/profile.d/autojump.sh

	autoload -U compinit && compinit -u

source /home/karim/.config/broot/launcher/bash/br
zmodload zsh/zprof
source $HOME/.tmp_commands.bash
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
#source $HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
#my-fzf-tab() {
#  functions[compadd]=$functions[-ftb-compadd]
#  zle fzf-tab-complete
#}
#zle -N my-fzf-tab
#
#add-zsh-hook precmd bind-tab
#bind-tab() {
#  bindkey '\t' fzf-tab-complete
#  bindkey $terminfo[kcbt] fzf-tab-complete
#}
