#!/bin/bash

MIRROR_PATH=$HOME/vms/lxc/oxvm_mirror/data/mirror/repo/out

find $MIRROR_PATH | grep FETCH_HEAD | sed "s|$MIRROR_PATH/||g" | sed 's|/FETCH_HEAD||g' | sed 's|\./||g'
