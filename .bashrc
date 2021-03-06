# Interactive only
[ -n "$PS1" ] || return


##############################################################################
# Environment options
##############################################################################

# PATH (in reverse priority order)
PATH="/usr/bin:/bin:/usr/sbin:/sbin"
[[ -d "/usr/local/sbin" ]] && PATH="/usr/local/sbin:$PATH"
[[ -d "/usr/local/bin" ]] && PATH="/usr/local/bin:$PATH"
[[ -d "/usr/texbin" ]] && PATH="/usr/texbin:$PATH"
[[ -d "$HOME/.bin" ]] && PATH="$HOME/.bin:$PATH"
export PATH

# Make vim the default editor
export EDITOR="vim"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell


##############################################################################
# History
##############################################################################

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL="ignorespace:erasedups"

# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:&:[fb]g"

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

##############################################################################
# Aliases
##############################################################################

# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

# Shortcuts
alias db="cd ~/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias s="cd ~/Source"
alias g="git"
alias h="history"

# ls

#####
# TODO: removing ls colors for now until I have time to make it readable on dark background
#
# # Detect which `ls` flavor is in use
# if ls --color > /dev/null 2>&1; then # GNU `ls`
#         colorflag="--color"
# else # OS X `ls`
#         colorflag="-G"
# fi
#
# # Always use color output for `ls`
# alias ls="command ls ${colorflag}"
# export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

alias la="ls -AF ${colorflag}"
alias ll="ls -lF ${colorflag}"
alias lla="ls -lAF ${colorflag}"

# List only directories
alias lsd='ls -lF ${colorflag} | grep "^d"'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

##############################################################################
# Colors
# https://github.com/gf3/dotfiles
##############################################################################

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
        export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
        export TERM=xterm-256color
fi

# if tput setaf 1 &> /dev/null; then
#         tput sgr0
#         if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
#             MAGENTA=$(tput setaf 0)
#             RED=$(tput setaf 1)
#             GREEN=$(tput setaf 2)
#             YELLOW=$(tput setaf 3)
#             BLUE=$(tput setaf 4)
#             MAGENTA=$(tput setaf 5)
#             CYAN=$(tput setaf 6)
#             WHITE=$(tput setaf 7)
#             LTGRAY=$(tput setaf 8)
#             LTRED=$(tput setaf 9)
#             LTGREEN=$(tput setaf 10)
#             LTYELLOW=$(tput setaf 11)
#             LTBLUE=$(tput setaf 12)
#             LTMAGENTA=$(tput setaf 13)
#             LTCYAN=$(tput setaf 14)
#             WHITE=$(tput setaf 15)
#             DKGRAY=$(tput setaf 16)

#             ORANGE=$(tput setaf 172)
# 	    	PURPLE=$(tput setaf 141)
#         else
#                 PURPLE=$(tput setaf 1)
#                 GREEN=$(tput setaf 2)
#                 YELLOW=$(tput setaf 3)
#                 ORANGE=$(tput setaf 4)
#                 MAGENTA=$(tput setaf 5)
#                 CYAN=$(tput setaf 6)
#                 WHITE=$(tput setaf 7)

#         fi
#         BOLD=$(tput bold)
#         RESET=$(tput sgr0)
# else
	# http://misc.flogisoft.com/bash/tip_colors_and_formatting
    RESET="\033[0m"

    BOLD="\033[1m"
    DIM="\033[2m"
    UNDERLINE="\033[4m"
    BLINK="\033[5m"
    INVERT="\033[7m"
    HIDDEN="\033[8m"

    DEFAULT="\033[39m"
    BLACK="\033[30m"
    RED="\033[31m"
    GREEN="\033[32m"
    YELLOW="\033[33m"
    BLUE="\033[34m"
    MAGENTA="\033[35m"
    CYAN="\033[36m"
    LTGRAY="\033[37m"
    DKGRAY="\033[90m"
    LTRED="\033[91m"
    LTGREEN="\033[92m"
    LTYELLOW="\033[93m"
    LTBLUE="\033[94m"
    LTMAGENTA="\033[95m"
    LTCYAN="\033[96m"
    WHITE="\033[97m"

    BGDEFAULT="\033[41m"
    BGBLACK="\033[40m"
    BGRED="\033[41m"
    BGGREEN="\033[42m"
    BGYELLOW="\033[43m"
    BGBLUE="\033[44m"
    BGMAGENTA="\033[45m"
    BGCYAN="\033[46m"
    BGLTGRAY="\033[47m"
    BGDKGRAY="\033[100m"
    BGLTRED="\033[101m"
    BGLTGREEN="\033[102m"
    BGLTYELLOW="\033[103m"
    BGLTBLUE="\033[104m"
    BGLTMAGENTA="\033[105m"
    BGLTCYAN="\033[106m"
    BGWHITE="\033[107m"
# fi

export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET


##############################################################################
# Prompt
##############################################################################

function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}

function parse_git_branch() {
    cdgit branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

function git_info() {
    # check if we're in a git repo
    git rev-parse --is-inside-work-tree &>/dev/null || return

    # quickest check for what branch we're on
    branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')

    # check if it's dirty (via github.com/sindresorhus/pure)
    dirty=$(git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo -e $RED"*")

    echo -e " "$GREEN$branch$dirty
}

# full path in title bar, basename in tab
export PS1="\[\e]2;\w\a\]\[\e]1;\W\a\]\n\[${CYAN}\]\h \[$YELLOW\]\w\$(git_info)\[$DEFAULT\]\n\$ \[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"
export SUDO_PS1="\n\[${CYAN}\]\h \[$YELLOW\]\w\n\[$BGRED$WHITE\][\u] #\[$RESET\] "


##############################################################################
# Completion
##############################################################################

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh
