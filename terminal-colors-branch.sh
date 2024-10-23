# -------------- terminal-colors-branch ----------------

# Colors for the prompt
blue="\033[01;34m"
white="\033[01;37m"
green="\033[01;32m"
yellow="\033[0;33m"
pink="\033[1;35m"

# Brackets needed around non-printable characters in PS1
ps1_blue='\['"$blue"'\]'
ps1_green='\['"$green"'\]'
ps1_white='\['"$white"'\]'
ps1_yellow='\['"$yellow"'\]'
ps1_pink='\['"$pink"'\]'

parse_git_branch() {
    gitstatus=`git status 2> /dev/null`
    if [[ `echo $gitstatus | grep "Changes to be committed"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1***)/'
    elif [[ `echo $gitstatus | grep "Changes not staged for commit"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1**)/'
    elif [[ `echo $gitstatus | grep "Untracked"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1*)/'
    elif [[ `echo $gitstatus | grep "nothing to commit"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    else
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1?)/'
    fi
}

parse_git_branch_color() {
    br=$(parse_git_branch)
    if [[ $br == "(master)" || $br == "(master*)" || $br == "(master**)" || $br == "(master***)" ]]; then
        echo -e "${blue}"
    else
        echo -e "${yellow}"
    fi
}

export PS1="$ps1_green@\h:$ps1_pink\W\[ \$(parse_git_branch_color)\]\$(parse_git_branch) $ps1_blue\$$ps1_white "