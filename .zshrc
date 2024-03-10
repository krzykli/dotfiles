# https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
# profile
if [[ -v ZSH_PROFILE ]]; then
    zmodload zsh/zprof
fi
source ~/zsh-defer/zsh-defer.plugin.zsh


source ~/.atlassian.zsh
eval "$(starship init zsh)"

export EDITOR="nvim"
export VISUAL="nvim"
export NEOVIDE_MULTIGRID="1"

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export NVIM_APPNAME="basic"
export PATH="$HOME/.local/share/basic/mason/bin:$PATH"
export PATH=/Users/kklimczyk/.asdf/installs/poetry/1.6.1/bin:$PATH
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

init_pyenv () {
    eval "$(pyenv init -)"
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
}

init_nvm () {
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
}

logs() {
  service=`basename $PWD`

  if [[ -n "$service" ]]; then
    env=$(echo "ddev adev stg-apse2 prod-apse2" | tr ' ' '\n' | fzf --height=30% --reverse)

    if [[ -n "$env" ]]; then
      open http://go/logs/$service/$env
    fi
  fi
}

token() {
  service=`basename $PWD`

  env=$(echo "dev staging prod" | tr ' ' '\n' | fzf --height=30% --reverse)

  if [[ -n "$env" ]]; then
    atlas slauth token -a $service -e $env -g continuous-control-monitoring-dl-admins | pbcopy
    echo "🎉 $service $env slauth token copied to clipboard"
  fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
conda_init() {
    __conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
}


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


# zsh-defer conda_init
zsh-defer source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
zsh-defer source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# fzf
export FZF_COMPLETION_TRIGGER=';;'

source ~/.config/lf_icons.zsh

# go
export PATH="$HOME/go/bin:$PATH"

source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/vi_mode.zsh
source ~/.config/zsh/widgets.zsh
source ~/.config/zsh/lf.zsh

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
bindkey -r "^J"

source ~/.fzf.zsh

run_pipe() {
    execute_pipeline $(get_pipelines | fzf --reverse --height 30%)
}


# edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# zprof
if [[ -v ZSH_PROFILE ]]; then
    zprof
fi


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
zsh-defer source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"
