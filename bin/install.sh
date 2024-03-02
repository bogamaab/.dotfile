#!bin/sh

# The next script is based on the TechDufus instalation script.
# I just wanna have a base to understand the process and how to had a successful
# installation in my workspaces. Checkout the link please:
# https://github.com/TechDufus/dotfiles/tree/main

# color codes
RESTORE='\033[0m'
NC='\033[0m'
BLACK='\033[00;30m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
SEA="\\033[38;5;49m"
LIGHTGRAY='\033[00;37m'
LBLACK='\033[01;30m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'
OVERWRITE='\e[1A\e[K'

# emoji codes
CHECK_MARK="${GREEN}\xE2\x9C\x94${NC}"
X_MARK="${RED}\xE2\x9C\x96${NC}"
PIN="${RED}\xF0\x9F\x93\x8C${NC}"
CLOCK="${GREEN}\xE2\x8C\x9B${NC}"
ARROW="${SEA}\xE2\x96\xB6${NC}"
BOOK="${RED}\xF0\x9F\x93\x8B${NC}"
HOT="${ORANGE}\xF0\x9F\x94\xA5${NC}"
WARNING="${RED}\xF0\x9F\x9A\xA8${NC}"
RIGHT_ANGLE="${GREEN}\xE2\x88\x9F${NC}"

DOTFILES_LOG="$HOME/.dotfiles.log"

# the next function run a task given below
function _task {
    if [[ $TASK != ""]]; then
        printf "${OVERWRITE}${LGREEN} [✓] ${LGREEN}${TASK}\n"
    fi

    # set new task title and print
    TASK=$1
    printf "${LBLACK} [ ]  ${TASK} \n${LRED}"
}

function _cmd {
    # create log if it doesn't exist
    if ! [[ -f $DOTFILES_LOG ]]; then
        touch $DOTFILES_LOG
    fi

    # redirect stdout to dotfile.log
    > $DOTFILES_LOG

    # hide stdout, on error we print and exit
    if eval "$1" 1> /dev/null 2> $DOTFILES_LOG; then
        return 0 # success
    fi

    # read error from log and add spacing
    printf "${OVERWRITE}${LRED} [X] ${TASK}$}{LRED}\n"
    while read line; do
        printf "      ${line}\n"
    done < $DOTFILES_LOG
    printf "\n"
    #remove log file
    rm $DOTFILES_LOG
    # exit installation
    exit 1
}

function _clear_task {
    TASK=""
}

function _taks_done {
    printf "${OVERWRITE}${LGREEN} [✓]  ${LGREEN}${TASK}\n"
    _clear_task
}

set -e

# Paths
CONFIG_DIR="$HOME/.config/"
# VAULT_SECRET="$HOME/.ansible-vault/vault.secret"
DOTFILES_DIR="$HOME/.dotfile"
SSH_DIR="$HOME/.ssh"
# IS_FIRST_RUN="$HOME/.dotfiles_run"


function ubuntu_setup() {
    if ! dpkg -s ansible >/dev/null 2>&1; then
        _task "Install Ansible"
        _cmd "sudo apt-get update"
        _cmd "sudo apt install -y software-properties-common"
        _cmd "sudo apt-add-repository -y ppa:ansible/ansible"
        _cmd "sudo apt update"
        _cmd "sudo apt install -y ansible"
        _cmd "sudo apt install python3-argcomplete"
        _cmd "sudo active-global-python-argcomplete3"
    fi
}


