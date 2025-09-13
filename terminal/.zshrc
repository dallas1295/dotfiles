# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/dallas/.zsh/completions:"* ]]; then export FPATH="/Users/dallas/.zsh/completions:$FPATH"; fi
# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/dallas/.zsh/completions:"* ]]; then
  export FPATH="/Users/dallas/.zsh/completions:$FPATH"
fi

# Auto-launch tmux with named session
# if [[ -z "$TMUX" ]] && [[ -n "$PS1" ]]; then
#     # If "terminal" session exists, attach to it
#     if tmux has-session -t terminal 2>/dev/null; then
#         tmux attach -t terminal
#     else
#         # Otherwise create it and attach
#         tmux new-session -s terminal
#     fi
# fi
bindkey -v

# zsh-completions
fpath=(/usr/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion)

# environment calls
export EDITOR=hx
export VISUAL=$EDITOR
export TERMINAL='ghostty'
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

alias vi='hx'

alias notes='nvim ~/Library/Mobile\ Documents/com~apple~CloudDocs/vaults/notes'

# ls shows hidden files & colorize
alias ls='ls -aG'

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/gruvvy.omp.json)"
eval "$(zoxide init zsh)"

. "/Users/dallas/.deno/env"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(rbenv init - zsh)"
eval "$(~/.local/bin/mise activate)"
export PATH=/Users/dallas/Go/bin:/Users/dallas/.local/share/mise/installs/deno/2.5.0/bin:/Users/dallas/.local/share/mise/installs/deno/2.5.0/.deno/bin:/Users/dallas/.local/share/mise/installs/elixir/1.18.4-otp-28/bin:/Users/dallas/.local/share/mise/installs/elixir/1.18.4-otp-28/.mix/escripts:/Users/dallas/.local/share/mise/installs/go/1.25.1/bin:/Users/dallas/.local/share/mise/installs/lua/5.4.8/bin:/Users/dallas/.local/share/mise/installs/lua/5.4.8/luarocks/bin:/Users/dallas/.local/share/mise/installs/node/24.8.0/bin:/Users/dallas/.local/share/mise/installs/npm/11.6.0/bin:/Users/dallas/.local/share/mise/installs/python/3.13.7/bin:/Users/dallas/.local/share/mise/installs/ruby/3.4.5/bin:/Users/dallas/.cargo/bin:/Users/dallas/.local/share/mise/installs/zig/0.15.1/bin:/Users/dallas/.rbenv/shims:/Users/dallas/.pyenv/shims:/Users/dallas/.deno/bin:/Users/dallas/.cargo/bin:/opt/homebrew/opt/python@3.13/libexec/bin:/Users/dallas/.local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/dallas/.cargo/bin:/opt/homebrew/opt/python@3.13/libexec/bin:/Users/dallas/.local/bin:/Applications/Ghostty.app/Contents/MacOS:/Users/dallas/go/bin:/Users/dallas/go/bin
