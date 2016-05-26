#!/bin/bash

# Vagrant

function vag() {
    LXC_ROOT='/Volumes/Data/oxid/vms/lxc'
    VM_ROOT='/volume'
    if [[ $PWD == "$LXC_ROOT"* ]]; then
        LXC_PWD=$(echo $PWD | sed "s|$LXC_ROOT|$VM_ROOT|g")
        lxc -t "bash -c \". ~/.bash_functions && cd \"$LXC_PWD\" && $@\""
    else
        $@
    fi
}

function vup() { vag vagrant up $@ }
function vupp() { vag vagrant up --provider=parallels $@ }
function vupv() { vag vagrant up --provider=virtualbox $@ }
function vupl() { vag vagrant up --provider=lxc $@ }
function vssh() { vag vagrant-ssh $@ }
function vstat() { vag vagrant status $@ }
function vgl() { vag vagrant global-status $@ }
function vpro() { vag vagrant provision $@ }
function vpros() { vag vagrant provision --provision-with=shell $@ }
function vdes() { vag vagrant destroy -f $@ }
function vha() { vag vagrant halt $@ }
function vre() { vag vagrant reload $@ }

# Git

function pull {
    local BRANCH=`git rev-parse --abbrev-ref HEAD`
    git pull --rebase origin $BRANCH
}

function push {
    local BRANCH=`git rev-parse --abbrev-ref HEAD`
    git push origin $BRANCH
}

# Grepping

function lsgr {
    local QUERY

    QUERY=$1
    ls | grep $QUERY
}

function hgr {
    local QUERY=$1

    history | grep "$QUERY"
}

function psgr {
    local QUERY=$1

    ps aux | grep "$QUERY"
}

# OXID related

function gcob {
    git clone git@github.com:OXID-eSales/$1.git --branch $2 $2/
}

function cor() {
    local REPO=$1
    git clone ~/Documents/work/oxid/repo/_mirror/OXID-eSales/$REPO
    local CWD=`pwd`
    cd $REPO && git remote set-url origin git@github.com:OXID-eSales/$REPO.git
    cd $CWD
}

# Misc

function bak {
    local FN=$1

    if [ -z "$FN" ]
    then
        echo 'Please specify file to backup'
        exit 1
    fi

    cp $FN $FN.bak && echo "Backup created as: $FN.bak"
}

function vimns() {
    touch $1
    chmod +x $1
    vim $1
}

# fzf

cor-widget() {
    if [[ $BUFFER == cor\ * ]] ; then
        QUERY=${BUFFER#cor }
        OUT=`cat /Users/oxid/Documents/work/oxid/repo/_mirror/list.txt | grep OXID | cut -d/ -f2 | fzf -q "$QUERY"`

        if [[ $? == 0 ]] ; then
            BUFFER="cor $OUT"
            zle redisplay
            zle end-of-line
            zle accept-line
        else
            zle redisplay
        fi
    else
        zle expand-or-complete
    fi
}
zle -N cor-widget
bindkey '^I' cor-widget

qcd-widget() {
    cd `cat ~/.qcd.txt | fzf`
    zle redisplay
    zle accept-line
}
zle -N qcd-widget
bindkey '^Q' qcd-widget

export FZF_DEFAULT_OPTS="--reverse"

vs(){
  #List all vagrant boxes available in the system including its status, and try to access the selected one via ssh
  cd $(cat ~/.vagrant.d/data/machine-index/index | jq '.machines[] | {name, vagrantfile_path, state}' | jq '.name + "," + .state  + "," + .vagrantfile_path'| sed 's/^"\(.*\)"$/\1/'| column -s, -t | sort -rk 2 | fzf | awk '{print $3}'); vagrant ssh
}

fgl() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}


# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
