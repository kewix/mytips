#Nateev .bashrc

#aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
export GREP_OPTIONS='--color=auto'

#history
bind '"\e[5~":history-search-backward'
bind '"\e[6~":history-search-forward'
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
#completion cyclique
bind '"²":menu-complete'
#montrer les possibilités si choix ambigu dans la completion
bind "set show-all-if-ambiguous on"
#ignorer la casse pour la completion
bind "set completion-ignore-case on"
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

#calculatrice
calc(){ awk "BEGIN{ print $* }" ;}

# Add color to MAN
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# UP 4
up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

# Extract any file
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

########################################################################
# Matthew's Git Bash Prompt, customized by Mike
########################################################################
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
LIGHT_YELLOW="\[\033[1;33m\]"
          GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_BLUE="\[\033[1;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

function parse_git_branch {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern="# Your branch is (.*) '"
  diverge_pattern="# Your branch and (.*) have diverged"
  
  if [[ ! ${git_status}} =~ "working directory clean" ]]; then
    state="${RED}⚡"
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead of" ]]; then
      remote="${YELLOW}↑"
    else
      remote="${YELLOW}↓"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}↕"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " (${branch})${remote}${state}"
  fi
}

function git_dirty_flag {
  git status 2> /dev/null | grep -c : | awk '{if ($1 > 0) print "⚡"}'
}

function prompt_func() {
    previous_return_value=$?;
    #The lowercase w is the full current working directory
    prompt="${LIGHT_BLUE}\t ${LIGHT_GREEN}\u@\h${TITLEBAR} ${LIGHT_BLUE}\w${LIGHT_GREEN}$(parse_git_branch) ${COLOR_NONE}"
    
    #Capital W is just the trailing part of the current working directory
    #prompt="${TITLEBAR}${BLUE}[${RED}\W${GREEN}$(parse_git_branch)${BLUE}]${COLOR_NONE}"
    
    if test $previous_return_value -eq 0
    then
        PS1="${prompt}> "
    else
        PS1="${prompt}${RED}>${COLOR_NONE} "
    fi
}

PROMPT_COMMAND=prompt_func
