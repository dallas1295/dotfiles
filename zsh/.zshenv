# ~/.zshenv — sourced by EVERY zsh (interactive, login, scripts)
# Env vars + PATH live here so non-interactive shells (emacs compile, zsh -c)
# get them too — zsh's answer to fish_user_paths

export SUDOEDITOR=nvim
export EDITOR=nvim
export VISUAL="$EDITOR"
export TERMINAL=foot

# PATH — mirrors fish_user_paths (~/.local/bin, ~/thirdparty/bin, ~/go/bin,
# ~/.cargo/bin, ~/opt/bin, ~/.opencode/bin), prepended, auto-deduplicated.
# typeset -U keeps the path array free of duplicates — no dedup loops needed.
# ~/.cargo/bin listed here replaces sourcing ~/.cargo/env.
typeset -U path
path=("$HOME/.opencode/bin"
      "$HOME/opt/bin"
      "$HOME/.cargo/bin"
      "$HOME/go/bin"
      "$HOME/thirdparty/bin"
      "$HOME/.local/bin"
      $path)
