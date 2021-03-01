set fish_git_dirty_color "#FF3322"
set fish_git_not_dirty_color green

set KK_MAC 1

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_status (git status -s)

  if test -n "$git_status"
    echo (set_color $fish_git_dirty_color)$branch(set_color normal)
  else
    echo (set_color $fish_git_not_dirty_color)$branch(set_color normal)
  end
end

set -gx EDITOR /usr/local/bin/nvim
set -gx UWHPSC /Users/mentos/Developer/hpc/uwhpsc
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

set -gx LIGHT_COLOR base16-gruvbox-light-soft.yml
set -gx DARK_COLOR base16-gruvbox-dark-soft.yml

alias day "alacritty-colorscheme -V apply $LIGHT_COLOR"
alias night "alacritty-colorscheme -V apply $DARK_COLOR"
alias toggle "alacritty-colorscheme -V toggle $LIGHT_COLOR $DARK_COLOR"

alias vim nvim
alias mysql /usr/local/mysql/bin/mysql
alias mysqladmin /usr/local/mysql/bin/mysqladmin

starship init fish | source
