(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)

  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))

  (meow-leader-define-key
   ;; Files and Consult
   '("/" . consult-ripgrep)
   '("f r" . consult-recent-file)
   '("f d" . dired)
   '("f f" .  dired-jump)
   '("r g" . consult-ripgrep)
   '("r q" . query-replace)
   '("i" . consult-buffer)
   '("d b" . consult-flymake)

   ;; Vterm
   '("t t" . vterm-toggle)

   ;; Magit
   '("l g" . magit-status)
   '("l d" . magit-diff-buffer-file)

   ;; Projects
   '("SPC" . find-file)
   '("." . projectile-find-file)
   '("p p" . projectile-switch-project)
   '("p l" . projectile-grep)
   '("p d" . projectile-dired)
   '("p b" . projectile-switch-to-buffer)
   '("p t" . projectile-run-vterm)
   '("p k" . projectile-kill-buffers)
   '("p v" . consult-projectile)
   '("p r" . projectile-replace)

   ;; Window bindings
   '("w v" . split-window-right)
   '("w s" . split-window-below)
   '("w d" . delete-window)

   ;; Buffer
   '("," . consult-buffer)
   '("b d" . (lambda () (interactive) (kill-buffer (current-buffer))))
   '("b l" . (lambda () (interactive) (switch-to-buffer nil)))
   ;; '("i" . ibuffer)
   '("b S" . my/save-all-buffers)
   '("b r o" . org-babel-execute-buffer)
   '("b r r" . revert-buffer)
   '("b r e" . eval-buffer)

   ;; Org
   '("o a" . org-agenda)
   '("o n" . org-capture)
   '("o l" . (lambda () (interactive) (find-file "~/org/life.org")))
   '("o g" . (lambda () (interactive) (find-file "~/org/coding.org")))

   ;; eglot
   '("d f" . eglot-format)
   '("d e n" . flymake-goto-next-error)    ;; next diagnostic
   '("d e p" . flymake-goto-prev-error)    ;; prev diagnostic
   '("d s" . consult-imenu)
   '("d S" . consult-imenu-multi)
   '("d a" . eglot-code-actions)
   '("d i" . eglot-find-implentation)
   '("d r" . xref-find-references)
   '("d d" . xref-find-definitions)

   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))

  (meow-normal-define-key
   '("0" . my/meow-digit-or-expand)
   '("9" . my/meow-digit-or-expand)
   '("8" . my/meow-digit-or-expand)
   '("7" . my/meow-digit-or-expand)
   '("6" . my/meow-digit-or-expand)
   '("5" . my/meow-digit-or-expand)
   '("4" . my/meow-digit-or-expand)
   '("3" . my/meow-digit-or-expand)
   '("2" . my/meow-digit-or-expand)
   '("1" . my/meow-digit-or-expand)
   '("M-f" . forward-word)
   '("M-b" . backward-word)
   '("M-l" . next-buffer)
   '("M-h" . previous-buffer)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("s" . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("a" . meow-append)
   '("A" . (lambda () (interactive) (end-of-line) (meow-insert)))
   '("b" . my/meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . my/meow-delete-or-kill)
   '("M-d" . my/kill-char)
   '("D" . meow-backward-delete)
   '("f" . meow-next-word)
   '("F" . my/next-word-extend)
   '("M-f" . meow-next-)
   '("M-d" . my/cancel)
   '("G" . end-of-buffer)
   '("g g" . beginning-of-buffer)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("/" . consult-line)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("C-r" . undo-redo)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("'" . repeat)
   '("C" . my/mc-add-cursor-below)
   '("M-C" . my/mc-delete-cursor)
   '("~" . my/change-caps)
   '("<escape>" . ignore)
   (global-unset-key (kbd "C-h"))
   (global-unset-key (kbd "C-j"))
   (global-unset-key (kbd "C-k"))
   (global-unset-key (kbd "C-l"))
   '("C-h" . windmove-left)
   '("C-j" . windmove-down)
   '("C-k" . windmove-up)
   '("C-l" . windmove-right)))


(setq meow-mode-state-list
      '((dired-mode . motion)
        (minibuffer-mode . insert)
        (elfeed-search-mode . motion)
        (org-mode . normal)
        (elfeed-show-mode . motion)
        (erc-mode . insert)
        (vterm-mode . insert)
        (pdf-view-mode . motion)
        (calibredb-search-mode . motion)
        (dirvish-mode . motion)
        (messages-buffer-mode . motion)
        (help-mode . motion)
        (info-mode . motion)
        (occur-mode . motion)
        (pass-mode . motion)
        (grep-mode . motion)
        (compilation-mode . motion)
        (messages-buffer-mode . motion)
        (special-mode . motion)))

(use-package meow
  :ensure t
  :config
  (meow-setup)
  (setq meow-use-cursor-position-hack t)
  (setq meow-cursor-type-insert '(bar . 2))
  (meow-global-mode 1)
  (add-hook 'meow-switch-state-hook
            (defun my/toggle-diagnostics-for-meow (_state)
              (when (meow-normal-mode-p)
                (font-lock-flush))))
  (meow-thing-register 'angle
                       '(regexp "<" ">")
                       '(regexp "<" ">"))
  (meow-thing-register 'double-quote
                       '(regexp "\"" "\"")
                       '(regexp "\"" "\""))
  (meow-thing-register 'single-quote
                       '(regexp "'" "'")
                       '(regexp "'" "'"))
  (meow-thing-register 'backtick
                       '(regexp "`" "`")
                       '(regexp "`" "`"))
  (setq meow-char-thing-table
        '((?\[ . square)
          (?\< . angle)
          (?b . round)
          (?B . curly)
          (?q . double-quote)
          (?Q . single-quote)
          (?\` . backtick)
          (?e . symbol)
          (?w . window)
          (?p . paragraph)
          (?l . line)
          (?d . defun))))

(defun my/meow-back-word (n)
  "Like meow-back-word but includes the character under cursor."
  (interactive "p")
  (let ((orig (point)))
    (meow-back-word n)
    (when (and meow-use-cursor-position-hack
               (region-active-p)
               (not (= (point) orig)))
      (let ((new-mark (min (1+ orig) (point-max))))
        (set-mark new-mark)
        (when meow--selection
          (setf (cadr meow--selection) new-mark))))))


(defun my/increment-number-at-point (&optional arg)
  (interactive "p")
  (let ((num (number-at-point)))
    (when num
      (let ((bounds (bounds-of-thing-at-point 'number)))
        (delete-region (car bounds) (cdr bounds))
        (insert (number-to-string (+ num (or arg 1))))))))

(defun my/decrement-number-at-point (&optional arg)
  (interactive "p")
  (my/increment-number-at-point (- (or arg 1))))

(defun my/cancel ()
  "Cancel meow selection or multiple cursors."
  (interactive)
  (if (and (boundp 'mc/num-cursors) (> mc/num-cursors 1))
      (mc/keyboard-quit)
    (meow-cancel-selection)))

(defun my/meow-delete-or-kill ()
  "Kill selection if active, otherwise delete char after point."
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (meow-delete)))

(defun my/kill-char ()
  "Kills a character adding it to killring, like x in vim"
  (interactive)
  (kill-region (point) (1+ (point))))

(defun my/mc-add-cursor-below ()
  "Add a cursor on the next line, maintaining column."
  (interactive)
  (unless mc--executing-command-for-fake-cursor
    (let ((col (current-column)))
      (mc/create-fake-cursor-at-point)
      (forward-line 1)
      (move-to-column col)
      (mc/maybe-multiple-cursors-mode))))

(defun my/mc-delete-cursor ()
  "Delete nearest fake cursor above real cursor and move there."
  (interactive)
  (unless mc--executing-command-for-fake-cursor
    (let* ((current-line (line-number-at-pos))
           (cursor-above
            (cl-find-if
             (lambda (o)
               (and (mc/fake-cursor-p o)
                    (< (line-number-at-pos (overlay-get o 'point))
                       current-line)))
             (sort (mc/all-fake-cursors)
                   (lambda (a b)
                     (> (line-number-at-pos (overlay-get a 'point))
                        (line-number-at-pos (overlay-get b 'point))))))))
      (when cursor-above
        (let ((target-line (line-number-at-pos (overlay-get cursor-above 'point)))
              (target-col (save-excursion
                            (goto-char (overlay-get cursor-above 'point))
                            (current-column))))
          (mc/remove-fake-cursor cursor-above)
          (forward-line (- target-line current-line))
          (move-to-column target-col)
          (mc/maybe-multiple-cursors-mode))))))

(defun my/change-caps ()
  "Toggle capitalization of char at point or active region."
  (interactive)
  (if (use-region-p)
      (let* ((start (region-beginning))
             (end (region-end))
             (text (buffer-substring start end)))
        (delete-region start end)
        (insert (if (equal text (downcase text))
                    (upcase text)
                  (downcase text))))
    (let ((char (char-after)))
      (when char
        (delete-char 1)
        (insert (if (eq char (downcase char))
                    (upcase char)
                  (downcase char)))))))

(defun my/meow-digit-or-expand ()
  "With selection, expand to Nth match. Otherwise, accumulate digit prefix."
  (interactive)
  (if (region-active-p)
      (let* ((key (event-basic-type (aref (this-command-keys-vector)
                                          (1- (length (this-command-keys-vector))))))
             (digit (- key ?0))
             (cmd (intern (format "meow-expand-%d" digit))))
        (call-interactively cmd))
    (call-interactively 'digit-argument)))

(defun my/next-word-extend (n)
  "Select next word, or extend existing selection to next word."
  (interactive "p")
  (unless (use-region-p)
    (push-mark (point) t nil))
  (goto-char (or (region-end) (point)))
  (forward-word n))
