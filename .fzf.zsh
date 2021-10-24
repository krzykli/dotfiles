# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# CTRL-g - projects
fzf-project-widget() {
    cd ~/workspace
    projects=`find . -type d -maxdepth 1`
    selected=`echo "$projects" | fzf --layout reverse --height 30% --prompt="🔍 workspace: " --pointer=▶`
    cd $selected
    zle reset-prompt
}
zle     -N   fzf-project-widget
bindkey '^g' fzf-project-widget

# CTRL-b - projects
fzf-review-widget() {
    cd ~/review
    projects=`find . -type d -maxdepth 1`
    selected=`echo "$projects" | fzf --layout reverse --height 30% --prompt="👀 review: " --pointer=▶`
    cd $selected
    clear
    echo "⏳ Pulling latest changes..."
    git pull --all
    selected=`git branch --all | fzf | xargs`
    git stash
    git checkout $selected
    clear
    echo "🚀 Ready to review: $selected"
    zle accept-line
}
zle     -N   fzf-review-widget
bindkey '^b' fzf-review-widget

# CTRL-b - projects
fzf-bookmark-widget() {
    selected=`cat ~/.config/bookmarks.txt | fzf --layout reverse --height 30%`
    split=("${(@s/,/)selected}")
    url=${split[2]}
    open `$url | sed 's/ *//'`
    zle accept-line
}
zle     -N   fzf-bookmark-widget
bindkey '^s' fzf-bookmark-widget
