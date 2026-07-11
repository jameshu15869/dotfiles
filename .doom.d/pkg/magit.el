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

(defun magit-section-strict-forward-sibling ()
  (interactive)
  (cond-let
    [[current (magit-current-section)]]
    ((not (oref current parent))
     (magit-section-goto 1))
    ([next (car (magit-section-siblings current 'next))]
     (magit-section-goto next))
    ((user-error "No next sibling"))))

(defun magit-section-strict-backward-sibling ()
  (interactive)
  (cond-let
    [[current (magit-current-section)]]
    ((not (oref current parent))
     (magit-section-goto 1))
    ([previous (car (magit-section-siblings current 'prev))]
     (magit-section-goto previous))
    ((user-error "No prev sibling"))))

(after! magit
  :config
  (setq fill-column 72)
  (add-hook! 'with-editor-finish-query-functions #'my/wrap-body)
  ;; (add-hook! 'with-editor-finish-query-functions #'my/test-skeleton)
  (add-hook! 'git-commit-mode-hook #'display-fill-column-indicator-mode)
  (map! :map 'magit-mode-map :n "z u" #'magit-section-up
        :map 'magit-mode-map :n "C-j" #'magit-section-strict-forward-sibling
        :map 'magit-mode-map :n "C-k" #'magit-section-strict-backward-sibling))
