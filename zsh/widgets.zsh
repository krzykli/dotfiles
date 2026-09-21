# CTRL-g - projects
fzf-project-widget() {
  local selected_directory
  selected_directory=$(find ~/workspace -maxdepth 1 -type d -exec basename {} \; | fzf --layout reverse --height 30% --prompt="🔍 workspace: " --pointer=▶)
  if [[ -n $selected_directory ]]; then
    BUFFER="cd ~/workspace/${selected_directory}"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle     -N   fzf-project-widget
bindkey '^g' fzf-project-widget

# CTRL-b - review
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

# CTRL-b - bookmarks
fzf-bookmark-widget() {
    selected=`cat ~/.config/bookmarks.txt | fzf --layout reverse --height 30%`
    split=("${(@s/,/)selected}")
    url=${split[2]}
    open `$url | sed 's/ *//'`
    zle accept-line
}
zle     -N   fzf-bookmark-widget
bindkey '^s' fzf-bookmark-widget

# vim shortkut
run-vim() {
    nvim
}
zle     -N   run-vim
bindkey '^ ' run-vim
