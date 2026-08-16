;;; .doom.d/pkg/avy.el -*- lexical-binding: t; -*-

(defun avy-action-embark (pt)
  (unwind-protect
      (save-excursion
        (goto-char pt)
        (embark-act))
    (select-window
     (cdr (ring-ref avy-ring 0))))
  t)

(use-package! avy
  :config
  (setq avy-all-windows t)
  (setf (alist-get ?. avy-dispatch-alist) 'avy-action-embark))
