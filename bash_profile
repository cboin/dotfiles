# Set the prompt 
if [ $(id -u) -eq 0 ];
then
	export PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '	
else
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '	
fi

# Set the PATH
export PATH=${HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:${PATH}

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make core files after crash
ulimit -c unlimited

## Color manpages
export LESS=R
export LESS_TERMCAP_mb="$(tput bold; tput setaf 2)"
export LESS_TERMCAP_md="$(tput bold; tput setaf 1)"
export LESS_TERMCAP_me="$(tput sgr0)"
export LESS_TERMCAP_se="$(tput sgr0)"
export LESS_TERMCAP_so="$(tput bold; tput setaf 3; tput setab 4)"
export LESS_TERMCAP_ue="$(tput sgr0)"
export LESS_TERMCAP_us="$(tput bold; tput setaf 4)"

# Some shortcuts
alias l='ls -F --color'
alias ls='ls -F --color'
alias ll='ls -lF --color'
alias la='ls -alF --color'
alias cls='clear ; ls -F --color'
alias cla='clear ; ls -alF --color'
alias cll='clear ; ls -lF --color'
alias diskspace='du -sh | sort -n -r | more'
alias f='find . | grep '
alias today='grep -h -d skip `date +%m/%d` /usr/share/calendar/*'

# Backup files
old () {
    if test "x$1" = "x" ; then
        echo "old: syntax error."
        exit 1
    fi

    local who 
    read -e -p "who ? " how

    for i in $*
    do
        new_name="$1.old-`date '+%Y%m%d-%H%M%S-%N'`"-${who}

        if test -L "$1" -o -d "$1" ; then
            mv $1 ${new_name}
        else
            cp $1 ${new_name}
        fi
        shift
    done
}
export old

# Extract archive
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

## Print return value
color_success="$(tput setaf 10)"
color_failure="$(tput setaf 9)"
color_normal="$(tput sgr0)"
color_fade="$(tput setaf 15)"

function _prompt_() {
    local err="$?"

    if [ "$err" -ne 0 ] ;
    then
        if [ "$err" -gt 128 -a "$err" -le 192 ]
        then # Failure or Signal
            echo "$color_fade[$color_failure$err$color_normal/$color_failure$(kill -l "$err"|tr '[:upper:]' '[:lower:]')$color_fade]$color_normal"
        else # Failure
            echo "${color_fade}[$color_failure$err$color_fade]$color_normal"
        fi
    else # OK 
        echo "$color_fade[${color_success}0$color_fade]$color_normal"
    fi
}

PROMPT_COMMAND="_prompt_"

# Git
export GIT_PS1_SHOWCOLORHINTS=yes
export GIT_PS1_SHOWUPSTREAM=verbose
source /usr/lib/git-core/git-sh-prompt
