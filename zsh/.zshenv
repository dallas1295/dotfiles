export SUDOEDITOR=nvim
export EDITOR=nvim
export VISUAL="$EDITOR"
export TERMINAL=foot

typeset -U path
path=("$HOME/.opencode/bin"
      "$HOME/opt/bin"
      "$HOME/.cargo/bin"
      "$HOME/go/bin"
      "$HOME/thirdparty/bin"
      "$HOME/.local/bin"
      $path)
