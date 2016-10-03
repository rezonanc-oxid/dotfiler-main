export FZF_ROOT="$HOME/bin/fzf"

. ~/homebrew/Cellar/fzf/*/shell/completion.zsh
. ~/homebrew/Cellar/fzf/*/shell/key-bindings.zsh

alias gco='$FZF_ROOT/pass_thru.sh mirror_repo'
alias gcoo='$FZF_ROOT/pass_thru.sh mirror_repo_oxid'
alias gcor='$FZF_ROOT/pass_thru.sh mirror_repo_rezonanc'
