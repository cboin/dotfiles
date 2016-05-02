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

# Some shortcuts
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
        echo "old: erreur de syntaxe."
        exit 1
    fi

    local qui
    read -e -p "qui ? " qui

    for i in $*
    do
        new_name="$1.old-`date '+%Y%m%d-%H%M%S-%N'`"-${qui}

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
