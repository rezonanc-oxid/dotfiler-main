#!/bin/bash

$FZF_ROOT/list_mirror_repo.sh | grep OXID | sed 's|OXID-eSales/||g'
