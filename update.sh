#!/bin/bash

cp $HOME/.vimrc ./arch_vimrc
git add . && git commit -m "$1" && git push origin master
