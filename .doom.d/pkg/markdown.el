;;; .doom.d/pkg/markdown.el -*- lexical-binding: t; -*-

(use-package! markdown-indent-mode
  :hook (markdown-ts-mode . markdown-indent-mode))
