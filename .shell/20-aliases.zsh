alias sudo="sudo -A"

alias rzsh="source ~/.zprofile"
alias p8="ping 8.8.8.8"

alias master="git checkout master"

# Global phpspec
alias pr='bin/phpspec run'
alias pd='bin/phpspec describe'
alias prn='bin/phpspec run -n'

# Global phpunit
alias pus='bin/phpunit -c app'

# Mac specific
alias ppwd='eval "echo `pwd` | pbcopy"'

# Docker specific
alias dockerenv='eval "$(docker-machine env default)"'

alias vihosts='sudo vim /etc/hosts'

alias cdd='cd /Volumes/Data/oxid/vms/lxc'

alias lxc='ssh -o LogLevel=quiet -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /Volumes/Data/oxid/vms/lxc_box/.vagrant/machines/default/parallels/private_key vagrant@lxc'
alias rdns='sudo killall -HUP mDNSResponder'

alias dls='docker inspect -f "{{.Name}} - {{.NetworkSettings.IPAddress }}" $(docker ps -q)'
alias dlsa='docker inspect -f "{{.Name}} - {{.NetworkSettings.IPAddress }}" $(docker ps -aq)'
