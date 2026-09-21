# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion and key bindings, when Homebrew's fzf package is installed.
[[ -f "/opt/homebrew/opt/fzf/shell/completion.zsh" ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh"
[[ -f "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" ]] && source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
