#!/bin/bash

ITEM="$1"

OUTPUT="$($FZF_ROOT/list_$ITEM.sh | fzf)"

[ ! -z $OUTPUT ] && $FZF_ROOT/act_$ITEM.sh "$OUTPUT"
