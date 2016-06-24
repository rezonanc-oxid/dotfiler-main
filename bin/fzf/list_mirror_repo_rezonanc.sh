#!/bin/bash

$FZF_ROOT/list_mirror_repo.sh | grep rezonanc-oxid | sed 's|rezonanc-oxid/||g'
