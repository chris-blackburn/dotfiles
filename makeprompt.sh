#!/bin/bash

# Generate the promptline and tmuxline files (config in located in vimrc)
vim "+PromptlineSnapshot! ~/.promptline.sh" "+qall"
vim "+Tmuxline lightline" "+TmuxlineSnapshot! ~/.tmuxline.sh" "+qall"
