# https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
# profile
if [[ -v ZSH_PROFILE ]]; then
    zmodload zsh/zprof
fi
# Optional local integrations. Keep the shell usable when a tool has been
# uninstalled or a machine-specific file is absent.
[[ -f "$HOME/.atlassian.zsh" ]] && source "$HOME/.atlassian.zsh"
eval "$(starship init zsh)"

export EDITOR="nvim"
export VISUAL="nvim"
export NEOVIDE_MULTIGRID="1"

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export NVIM_APPNAME="basic"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/basic/mason/bin:$PATH"
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

init_pyenv () {
    eval "$(pyenv init -)"
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
}

inv () {
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
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

function scan_docker_image() {
  local docker_image=""
  local output_json_file=""

  while [[ $# -gt 0 ]]; do
    case $1 in
      -d|--docker-image)
        docker_image="$2"
        shift 2
        ;;
      -o|--output-file)
        output_json_file="$2"
        shift 2
        ;;
      *)
        echo "Unknown option: $1"
        echo "Usage: scan_docker_image -d <docker_image> -o <output_json_file>"
        return 1
        ;;
    esac
  done

  if [[ -z $docker_image || -z $output_json_file ]]; then
    echo "Both --docker-image and --output-file are required."
    echo "Usage: scan_docker_image -d <docker_image> -o <output_json_file>"
    return 1
  fi

  docker run \
    -e AUTH_TOKEN=$(atlas slauth token -e staging --aud=sec-cs-image-scanner) \
    -i docker.atl-paas.net/asecurityteam/cs-image-scanner-client:v0.1.2 \
    "$docker_image" > "$output_json_file"
}

function search_artifactory() {
  local DIGEST="$1"
  if [[ -z "$USERNAME" || -z "$APASS" ]]; then
    echo "Error: AUSERNAME and APASS environment variables must be set."
    return 1
  fi
  curl -u"${USERNAME}":"${APASS}" \
    -X POST \
    -H 'Content-Type: text/plain; charset=utf-8' \
    https://packages.atlassian.com/artifactory/api/search/aql \
    -d @- << __EOF > "results.sha256__${DIGEST}.json"
items.find({
  "sha256":"${DIGEST}",
  "repo" : "atlassian-docker-immutable-local"
}).include("repo","path","name")
__EOF
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


# Optional prompt enhancements.
[[ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
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

kubeinit() {
    export KUBECONFIG=$(atlas kitt context:create --pid=$$)
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
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"

# Created by `pipx` on 2024-03-18 23:28:31
export PATH="$PATH:/Users/kklimczyk/.local/bin"

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
export PATH="/opt/atlassian/orbit/bin:$PATH"

export PATH="/Users/kklimczyk/.orbit/bin:$PATH"


export GPG_TTY=$(tty)
command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init - zsh)"


[[ -f "$HOME/.afm-git-configrc" ]] && source "$HOME/.afm-git-configrc"

# In Ghostty, start (or attach to) one persistent Tmux workspace. This stays
# out of other terminals and avoids nesting when already inside Tmux.
if [[ -o interactive && -z "$TMUX" && ( "$TERM_PROGRAM" == "ghostty" || "$TERM" == "xterm-ghostty" ) ]]; then
    exec tmux new-session -A -s main
fi
