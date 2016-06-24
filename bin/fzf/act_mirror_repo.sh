#!/bin/bash

ITEM="$1"
ROOT="$HOME/repo/out"
ITEM_PATH="$ROOT/$ITEM"

git clone $ITEM_PATH
