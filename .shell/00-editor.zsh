# Editor variables
GRAPHICAL_EDITOR=vim
TEXT_EDITOR=vim

# Export editor
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo ${GRAPHICAL_EDITOR}; else echo ${TEXT_EDITOR}; fi)"
