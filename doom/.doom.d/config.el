;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Hu Wenqiang"
      user-mail-address "huwqchn@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
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
(setq doom-theme 'doom-dracula
      doom-font (font-spec :family "Fira Code" :size 18 :weight 'medium))
(pushnew! initial-frame-alist '(width . 120) '(height . 45))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(map! :nmvo "n" #'evil-backward-char
      :nmvo "i" #'evil-forward-char
      :nmvo "e" #'evil-next-line
      :nmvo "u" #'evil-previous-line
      :nmvo "gu" #'evil-previous-visual-line
      :nmvo "ge" #'evil-next-visual-line
      :n "k" #'evil-insert
      :nv "K" #'evil-insert-line
      :ov "k" evil-inner-text-objects-map
      :nmvo "l" #'evil-undo
      :nmvo "h" #'evil-forward-word-end
      :nmvo "H" #'evil-forward-WORD-end
      :nmvo "N" #'evil-first-non-blank
      :nmvo "I" #'evil-last-non-blank
      :nmv "=" (if (eq evil-search-module 'evil-search) #'evil-ex-search-next #'evil-search-next)
      :nmv "-" (if (eq evil-search-module 'evil-search) #'evil-ex-search-previous #'evil-search-previous))

(cond (IS-MAC
       (setq mac-control-modifier 'control
             mac-command-modifier 'super
             mac-option-modifier 'alt
             mac-right-option-modifier 'meta
             mac-right-command-modifier 'hyper)))
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq url-proxy-services
		'(("http" . "127.0.0.1:19180")
		  ("https" . "127.0.0.1:19180")))
(use-package fira-code-mode
  :custom (fira-code-mode-disabled-ligatures '("int" "true" "false" "return"))
  :hook prog-mode)
(setq org-roam-directory "~/Documents/notes")
(use-package! org-roam
	:after org
	: commands
	(org-roam-buffer
	 org-roam-setup
	 org-roam-capture
	 org-roam-node-find)
	:config
	;;(setq org-roam-mode-sections
  ;;      (list #'org-roam-backlinks-insert-section
  ;;            #'org-roam-reflinks-insert-section
  ;;            #'org-roam-unlinked-references-insert-section))
	(org-roam-setup))
;;; roam v2 configuration
(setq org-roam-directory "~/Documents/org/roam")
(use-package! org-roam
  :after org
  :commands
  (org-roam-buffer
   org-roam-setup
   org-roam-capture
   org-roam-node-find)

  ;; =====  快捷键设置=====
  :init
  (map!
        :leader
        :prefix ("m" . "org-roam")
        "f" #'org-roam-node-find
        "i" #'org-roam-node-insert
        "b" #'org-roam-buffer-toggle
        "t" #'org-roam-tag-add
        "T" #'org-roam-tag-remove)
  ;; ===== END HERE ====
  :config
  (org-roam-setup))
;; Whenever you reconfigure a package, make sUre To wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your ttings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
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