#!/bin/bash

ITEM="$1"
ROOT="$HOME/repo/out"
MIRROR="$ROOT/$ITEM"

ITEM_TAIL=$(echo "$ITEM" | tr "/" "\n" | tail -n 1)

git clone $MIRROR

ORIGIN=$(cd $MIRROR && git remote get-url origin)
$(cd $ITEM_TAIL && git remote set-url origin "$ORIGIN")
$(cd $ITEM_TAIL && git remote add mirror "$MIRROR")
