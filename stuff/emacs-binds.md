# Emacs Keybindings

## File & Buffer

| Key | Command | Description |
|-----|---------|-------------|
| `C-x C-f` | `find-file` | Open file (or create new) |
| `C-x C-s` | `save-buffer` | Save file |
| `C-x k` | `kill-buffer` | Close buffer |
| `C-x b` | `switch-to-buffer` | Switch buffer |

## Navigation

| Key | Command | Description |
|-----|---------|-------------|
| `C-a` | `move-beginning-of-line` | Go to beginning of line |
| `C-e` | `move-end-of-line` | Go to end of line |
| `C-n` | `next-line` | Next line |
| `C-p` | `previous-line` | Previous line |
| `M-f` | `forward-word` | Forward by word |
| `M-b` | `backward-word` | Backward by word |
| `M-<` | `beginning-of-buffer` | Go to top of file |
| `M->` | `end-of-buffer` | Go to bottom of file |
| `C-v` | `scroll-up-command` | Page down |
| `M-v` | `scroll-down-command` | Page up |
| `C-l` | `recenter-top-bottom` | Recenter screen on cursor |

## Editing

| Key | Command | Description |
|-----|---------|-------------|
| `C-S-backspace` | `kill-whole-line` | Delete entire line |
| `C-k` | `kill-line` | Kill to end of line |
| `C-w` | `kill-region` | Cut selection |
| `M-w` | `kill-ring-save` | Copy selection |
| `C-y` | `yank` | Paste (from kill ring) |
| `C-/` | `undo` | Undo |
| `C-?` | `redo` | Redo (requires undo-tree) |

## Clipboard (System)

With `(setq select-enable-clipboard t)` in your config, `C-w`/`M-w`/`C-y` work with the system clipboard automatically. Otherwise:

| Key | Command | Description |
|-----|---------|-------------|
| `M-w` | `kill-ring-save` | Copy (also system clipboard if enabled) |
| `C-w` | `kill-region` | Cut (also system clipboard if enabled) |
| `C-y` | `yank` | Paste from kill ring |
| `M-x clipboard-kill-ring-save` | — | Copy to system clipboard |
| `M-x clipboard-kill-region` | — | Cut to system clipboard |
| `M-x clipboard-yank` | — | Paste from system clipboard |

## Selection / Mark

| Key | Command | Description |
|-----|---------|-------------|
| `C-Space` | `set-mark-command` | Start selection |
| `C-a C-Space C-e` | — | Select entire line |
| `C-x h` | `mark-whole-buffer` | Select all |
| `M-@` | `mark-word` | Select word (from cursor forward) |
| `C-x M-2` | — | Select word under cursor (custom, see below) |

## Window Management

| Key | Command | Description |
|-----|---------|-------------|
| `C-x 0` | `delete-window` | Close current window |
| `C-x 1` | `delete-other-windows` | Close all other windows |
| `C-x 2` | `split-window-below` | Split horizontally |
| `C-x 3` | `split-window-right` | Split vertically |
| `C-x o` | `other-window` | Switch between windows |

## Help & Eval

| Key | Command | Description |
|-----|---------|-------------|
| `C-h f` | `describe-function` | Look up function docs |
| `C-h v` | `describe-variable` | Look up variable docs |
| `C-h k` | `describe-key` | Show what a keybinding does |
| `M-:` | `eval-expression` | Evaluate Elisp expression |
| `C-x C-e` | `eval-last-sexp` | Eval expression before cursor |

## Select Word Under Cursor

Vanilla Emacs doesn't have a clean "select word under point" command. Add this to your `init.el`:

```elisp
(defun my/select-word-under-cursor ()
  (interactive)
  (backward-word)
  (mark-word)
  (exchange-point-and-mark))

(global-set-key (kbd "C-x M-2") 'my/select-word-under-cursor)
```

Or install `expand-region` for a more powerful approach:

```elisp
(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))
```

`C-=` will progressively expand selection: word → quotes → brackets → etc.
