set -o vi
bindkey -v
export KEYTIMEOUT=0.1
bindkey -M viins 'jk' vi-cmd-mode
bindkey -v "<C-a>" vi-beginning-of-line
bindkey -v "<C-e>" vi-end-of-line
