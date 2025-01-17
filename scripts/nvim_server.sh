#!/bin/sh
set -eu
SOCK_FOLDER=$HOME/.local/
mkdir -p $SOCK_FOLDER
SOCK=$SOCK_FOLDER/nvimsock
if [ -e "$SOCK" ]; then
	echo "Listening socket $SOCK already exists"
	ps ax | grep nvim
	return 1
fi
export NVIM_LISTEN_ADDRESS=$SOCK
# https://stackoverflow.com/questions/10408816/how-do-i-use-the-nohup-command-without-getting-nohup-out
nohup nvim --headless </dev/null >/dev/null 2>&1 &
