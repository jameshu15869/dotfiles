;;; ../dotfiles/.doom.d/pkg-config/magit.el -*- lexical-binding: t; -*-

(defun my/test-skeleton (force)
  (or force
      (y-or-n-p "This is a test. Force anyways?")))

(defun my/wrap-body (force)
  (or force
      (save-excursion
        (goto-char (point-min))
        ;; skip the header and mandatory blank line
        (forward-line 2)

        (while (not (eobp))
          (let ((beg (line-beginning-position))
                (end (line-end-position)))
            (goto-char end)
            (when (> (current-column) fill-column)
              (fill-region beg end)))
          (forward-line 1))
        t)))

(after! magit
  :config
  (setq fill-column 72)
  (add-hook! 'with-editor-finish-query-functions #'my/wrap-body)
  ;; (add-hook! 'with-editor-finish-query-functions #'my/test-skeleton)
  (add-hook! 'git-commit-mode-hook (display-fill-column-indicator-mode)))
