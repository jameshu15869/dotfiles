;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")

;; (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18))
;; unfortunately I don't think it's possible to get the nice texture healing on
;; emacs: https://github.com/harfbuzz/harfbuzz/discussions/4490#discussioncomment-7566290
(setq doom-font (font-spec :family "Monaspace Neon Frozen" :size 18))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(load! "pkg/magit.el")
(load! "pkg/denote.el")

(map! :leader
      (:prefix ("o" . "open")
       :desc "Projectile vterm" "v" #'projectile-run-vterm))

(map! :leader
      (:prefix ("TAB" . "workspace")
       :desc "Other workspace" "TAB" #'+workspace/other
       :desc "Display" "`" #'+workspace/display))

(defun my/save-all-buffers-before-doom-reload ()
  "Save all modified buffers before reloading Doom."
  (interactive)
  (save-some-buffers t)) ; t = save all without asking
(advice-add #'doom/reload :before #'my/save-all-buffers-before-doom-reload)

(map!
 :leader
 :desc "Save all buffers (silent)"
 "f s" (lambda () (interactive) (save-some-buffers t)))

(defun my/set-tab-line-theme ()
  (let ((active-tab-highlight-font "#00ff00"))
    (set-face-attribute 'tab-line-tab-current nil
			:underline active-tab-highlight-font
			)))

(use-package! tab-line
  :hook (after-init . global-tab-line-mode)
  :config
  (map! "C-}" #'tab-line-switch-to-next-tab)
  (map! "C-{" #'tab-line-switch-to-prev-tab)
  (map! "C-<tab>" #'tab-line-switch-to-next-tab)
  (map! :map (evil-normal-state-map evil-visual-state-map evil-insert-state-map)
        "C-<tab>" nil
        :n "C-c y" #'aya-create)
  (map! "C-<iso-lefttab>" #'tab-line-switch-to-prev-tab)
  (defun my/tab-line-select-visible-nth-tab (n)
    "Tab to switch to, 1-indexed. Will truncate to number of buffers in window."
    (let* ((tabs (tab-line-tabs-fixed-window-buffers))
           (tab-index (1- (min n (length tabs))))
           (candidate-tab (nth tab-index tabs)))
      (when candidate-tab
        (switch-to-buffer candidate-tab))))
  (my/set-tab-line-theme)
  (dotimes (i 9)
    (message (format "hi: %d" i))
    (map! :nvi (format "M-%d" i)
          `(lambda ()
             (interactive)
             (my/tab-line-select-visible-nth-tab ,i)))))

;; (after! centaur-tabs
;;   (map!) "C-}" #'centaur-tabs-forward
;;         "C-{" #'centaur-tabs-backward)
;;   (dotimes (i 9)
;;     (map! :n (format "M-%d" i)
;;           `(lambda ()
;;              (interactive)
;;              (centaur-tabs-select-visible-nth-tab ,i)))))

(defun files/find-file-vertical-split ()
  (interactive)
  (+evil/window-vsplit-and-follow)
  (call-interactively #'projectile-find-file))

(map! :leader
      :desc "Open file vertical split"
      "f v" #'files/find-file-vertical-split)

(defun files/find-file-horizontal-split ()
  (interactive)
  (+evil/window-split-and-follow)
  (call-interactively #'projectile-find-file))

(map! :leader
      :desc "Open file horizontal split"
      "f h" #'files/find-file-horizontal-split)

;; follow windows by default
(map! :leader
      :desc "Vertical split and follow"
      "w v" #'+evil/window-vsplit-and-follow)

(map! :leader
      :desc "Vertical split"
      "w V" #'evil-window-vsplit)

(map! :leader
      :desc "Horizontal split and follow"
      "w s" #'+evil/window-split-and-follow)

(map! :leader
      :desc "Horizontal split"
      "w S" #'evil-window-split)



(defun my/vterm-auto-insert-state (&rest _)
  (when (and (eq major-mode 'vterm-mode)
             (not (evil-insert-state-p)))
    (evil-insert-state)))

;; (set-evil-initial-state! 'vterm-mode 'insert)
;; (add-hook 'window-selection-change-functions #'my/vterm-auto-insert-state)
;; (add-hook 'window-buffer-change-functions #'my/vterm-auto-insert-state)

(after! vterm
  (remove-hook 'vterm-mode-hook #'mode-line-invisible-mode))

(after! eshell
  (remove-hook 'eshell-mode-hook #'mode-line-invisible-mode))

;; Terminal movement commands while in insert or normal mode
(after! persp-mode
  (map! "C-x TAB" doom-leader-workspace-map))
(map! :nvi
      "C-x h" #'evil-window-left
      "C-x j" #'evil-window-down
      "C-x k" #'evil-window-up
      "C-x l" #'evil-window-right)

(map! :leader
      (:prefix ("w" . "window")
       :desc "Delete window" "q" #'+workspace/close-window-or-workspace))
;; Unmap default so we can build good muscle memory
(map! :leader
      (:prefix ("w" . "window")
       :desc "Delete window" "q" #'delete-window
       "d" nil))

(after! vterm
  (define-key vterm-mode-map (kbd "C-c C-c") #'vterm--self-insert))

;; Make Cargo and compilation popups take up a big part of the screen
;; and focus
;; (disclaimer: from LLM)
(after! (compile rustic)
  (set-popup-rule! "^\\*\\(cargo\\|compilation\\|rustic-compilation\\)"
    :size 0.7
    :select t
    :quit t))

(map! "C-x C-x" #'ace-window)

(map! :v "v" #'er/expand-region
      :v "V" #'er/contract-region)


(defun new-workspace-with-vterm ()
  "Create a new workspace with vterm inside the current project"
  (interactive)
  (+workspace/new)
  (+vterm/here nil))
(after! persp-mode
  (map! "C-x TAB t" #'new-workspace-with-vterm))

;; make it easier to clone + add as a projectile project
(add-hook 'magit-post-clone-hook
          (lambda ()
            (let ((dir default-directory))
              (projectile-add-known-project dir)
              ;; Automatically switch to the project (opens dired/file list)
              (projectile-switch-project-by-name dir))))

(map! :after smerge-mode
      :map smerge-mode-map
      :prefix "C-c m"  ;; your custom prefix
      "n" #'smerge-next
      "p" #'smerge-prev
      "u" #'smerge-keep-upper
      "l" #'smerge-keep-lower
      "a" #'smerge-keep-all
      "RET" #'smerge-keep-current)

(map! :n "g w" #'evil-avy-goto-word-0)

(setq vterm-shell (or (executable-find "fish")
                      (executable-find "bash")))

;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'modus-vivendi)
(setq doom-theme 'doom-tokyo-night)

;; force commands like find-file-other-window to always
;; split vertically
(setq split-width-threshold 1
      split-height-threshold nil)

(defun my/preview-raw-content (url)
  "Download a raw content file via URL and open"
  (interactive "sEnter raw content URL: ")
  (let ((temp-file (make-temp-file "cloned-content-" nil)))
    (condition-case err
        (progn
          (url-copy-file url temp-file t)
          (find-file temp-file)
          (message "Successfully previewing content"))
      (t
       (when (file-exists-p temp-file)
         (delete-file temp-file))
       (message "Failed to preview: %s" (error-message-string err))))))

(setq projectile-indexing-method 'alien)

(map! :nvi "M-w" 'kill-current-buffer)

(defun my/run-python-same-window ()
  (interactive)
  (run-python)
  (switch-to-buffer (process-buffer (python-shell-get-process))))

(after! comint (map! :map comint-mode-map
                     :i "C-p" #'comint-previous-input
                     :i "C-n" #'comint-next-input))

(after! eshell (map! :map eshell-mode-map
                     :i "C-p" #'eshell-previous-matching-input-from-input
                     :i "C-n" #'eshell-next-matching-input-from-input))

;; corfu messes with C-p C-n for REPL/shell history
(dolist (hook '(inferior-python-mode-hook eshell-mode-hook))
  (add-hook hook (lambda () (corfu-mode -1))))

(after! org
  (map! :map org-mode-map
        :m "j" #'evil-next-visual-line
        :m "k" #'evil-previous-visual-line))

(use-package! super-save
  :ensure t
  :config
  (super-save-mode +1))
