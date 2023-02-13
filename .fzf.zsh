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


# fzf theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:-1,bg:-1,hl:#6297cc --color=fg+:#e86666,bg+:#262626,hl+:#5fd7ff --color=info:#afaf87,prompt:#3dcfff,pointer:#af5fff --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'
