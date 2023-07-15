alias ..="cd .."
alias cac="~/go/src/bitbucket.org/atlassian/compliance-as-code"
alias con="cd ~/.config"
alias cat=bat
alias cls=clear
alias dev="cd ~/workspace"
alias dockerrm='docker stop $(docker ps -aq)'
alias dockerstop='docker stop $(docker ps -aq)'
alias fenv='env | fzf'
alias gb="git branch | fzf-tmux -d 15"
alias gg="git grep"
alias gp="git pull"
alias gcm="git checkout master"
alias initnvm=". /usr/local/opt/nvm/nvm.sh"
alias initpyenv='init_pyenv'
alias initruby='eval "$(rbenv init -)"'
alias show="fzf --preview 'bat --color=always {}' --preview-window '~3'"
alias lg=lazygit
# alias nvim="~/nvim/bin/nvim"
alias v=nvim
alias vi=nvim
alias vim=nvim
alias ls="exa"
alias ll="exa -l"
alias mvn=mvnd

atlas_clone() {
    git clone git@bitbucket.org:atlassian/$1.git
}
