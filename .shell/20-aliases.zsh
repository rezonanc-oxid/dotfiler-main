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
alias ppwd='eval "echo -n `pwd` | pbcopy"'

# Docker specific
alias dockerenv='eval "$(docker-machine env default)"'

alias vihosts='sudo vim /etc/hosts'

alias cdd='cd /Volumes/Data/Users/oxid/vms/lxc'
alias cdbox='cd /Volumes/Data/Users/oxid/vms/box'

alias lxc='ssh -o LogLevel=quiet -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /Volumes/Data/Users/oxid/vms/box/.vagrant/machines/default/parallels/private_key vagrant@lxc'
alias rdns='sudo killall -HUP mDNSResponder'

alias dls='docker inspect -f "{{.Name}} - {{.NetworkSettings.IPAddress }}" $(docker ps -q)'
alias dlsa='docker inspect -f "{{.Name}} - {{.NetworkSettings.IPAddress }}" $(docker ps -aq)'

alias lxcroute='netstat -nr | grep 10.0.4 || sudo route -n add 10.0.3.0/24 192.168.33.10'
alias mirror_lxc_hosts='(cat /etc/hosts_static ; lxc cat /etc/hosts | tail -n +8) | sudo bash -c "cat > /etc/hosts"'
alias unmirror_lxc_hosts='sudo bash -c "cat /etc/hosts_static > /etc/hosts"'
alias lxc-ls='lxc sudo lxc-ls -f'

alias g='git'
