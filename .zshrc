# https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
# profile
if [[ -v ZSH_PROFILE ]]; then
    zmodload zsh/zprof
fi

source ~/.atlassian.zsh
eval "$(starship init zsh)"

export EDITOR="nvim"
export VISUAL="nvim"
export NEOVIDE_MULTIGRID="1"

export PATH="$HOME/.poetry/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

init_pyenv () {
    eval "$(pyenv init -)"
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kklimczyk/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kklimczyk/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/kklimczyk/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kklimczyk/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# man
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}


source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# fzf
export FZF_COMPLETION_TRIGGER=';;'

source ~/.config/lf_icons.zsh

# go
export PATH="$HOME/go/bin:$PATH"

source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/vi_mode.zsh
source ~/.config/zsh/widgets.zsh

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

source ~/.fzf.zsh
# zprof
if [[ -v ZSH_PROFILE ]]; then
    zprof
fi
