# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias l="ls"

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/.npm-packages/bin/

export WEECHAT_HOME=/work1/bmugnier/.weechat

#this is 2020 and ur distro still doesn't have this ffs
alias ls="ls --color=auto"
alias ll="ls -al"

#can't type properly
alias gti="git"
alias g="git"
alias maek="make"
alias cl="clear"
alias cls="clear"
alias j="jobs"
alias f="fg"
alias gf="fg"
alias cd..="cd .."

#gotta go fast
alias .1="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

#Misc
alias bell="echo -e '\a'"
alias csv="column -s, -t < "

__retry () {
	until "$@"; do :; sleep 1; done
}
alias retry=__retry

export PROMPT_COMMAND=get_exit_status

get_exit_status(){
	es=$?
	#PS1=$(echo "$PS1" | cut -c 3-)
	PS1="${PS1:2}"
	if [ ! $es -eq 0 ]
	then
		#PS1="✕ $PS1"
		PS1="x $PS1"
	else
		#PS1="• $PS1"
		PS1="¤ $PS1"
	fi
}

color_bash(){
	context-color -p --method md5sum
}

if [[ $- == *i* ]]
then
	PS1=". $(color_bash -p)\A\[$(tput sgr0)\] \[\e[1m\]\u\[\e[0m\]$(color_bash -p)@\[$(tput sgr0)\]\[\e[1m\]\h\[\e[0m\] $(color_bash -p):\j \[$(tput sgr0)\]\W \$ "
fi

export EDITOR=vim

#pastebin on steroids
alias tb="nc termbin.com 9999"

#urxvt-256color is a superset of xterm-256color, since a lot of brouettes don't
#have it we force compat mode
#export TERM="screen-256color"

if [[ "$BASH_VERSION" > "4.2.29" ]]; then
	shopt -s direxpand
fi

source /usr/share/bash-completion/completions/git
