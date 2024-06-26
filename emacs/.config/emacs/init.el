;; Straight package manager
(setq straight-repository-branch "develop")

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; packages
; shallow clones not working properly right now
; (setq straight-vc-git-default-clone-depth 1)
; org mode
(straight-use-package 'org-superstar)
(straight-use-package 'org-ref)
(straight-use-package 'org-roam)
(straight-use-package 'websocket)
(straight-use-package 'simple-httpd)
(straight-use-package '(org-roam-ui :type git :host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))
(straight-use-package 'org-attach-screenshot)
(straight-use-package 'ox-reveal)
; evil-mode
(straight-use-package 'evil)
(straight-use-package 'evil-collection)
(straight-use-package 'evil-snipe)
(straight-use-package 'evil-numbers)
(straight-use-package 'evil-leader)
(straight-use-package 'evil-surround)
(straight-use-package 'evil-nerd-commenter)
(straight-use-package 'evil-org)
; functionality
(straight-use-package 'helm)
(straight-use-package 'helm-bibtex)
(straight-use-package 'magit)
(straight-use-package 'general)
(straight-use-package 'avy)
(straight-use-package 'company)
(straight-use-package 'prescient)
(straight-use-package 'company-prescient)
(straight-use-package 'undo-tree)
; gui
(straight-use-package 'dashboard)
(straight-use-package 'which-key)
(straight-use-package 'all-the-icons)
(straight-use-package 'page-break-lines)
(straight-use-package 'telephone-line)
(straight-use-package 'doom-themes)
; programming
(straight-use-package 'eglot)
(straight-use-package 'yasnippet)
(straight-use-package 'yasnippet-snippets)
(straight-use-package 'cmake-mode)
(require 'cmake-mode)
(straight-use-package 'meson-mode)
(require 'meson-mode)
(add-hook 'meson-mode-hook 'company-mode)
(straight-use-package 'yaml-mode)
(straight-use-package 'origami)
(require 'origami)
;; languages
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
(require 'tree-sitter)
(require 'tree-sitter-langs)
(straight-use-package 'rust-mode)
(require 'rust-mode)
;; documents
(straight-use-package 'pdf-tools)
(straight-use-package 'auctex)
(straight-use-package 'cdlatex)
;; internet
(straight-use-package 'elpher)
(straight-use-package 'elfeed)
(straight-use-package 'elfeed-org)

;; Increases Garbage Collection During Startup
(setq startup/gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)
(defun startup/reset-gc () (setq gc-cons-threshold startup/gc-cons-threshold))
(add-hook 'emacs-startup-hook 'startup/reset-gc)

;; hide GUI
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; hide scroll bar in new frames
(defun my/disable-scroll-bars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))
(add-hook 'after-make-frame-functions 'my/disable-scroll-bars)

;; scroll off
(setq scroll-margin 7)
(setq scroll-conservatively 999) ;; do not center when scrolling

;; disable truncate lines
(set-default 'truncate-lines 0)

;; disable bell
(setq ring-bell-function 'ignore)

;; Line numbering
(add-hook 'prog-mode-hook 'display-line-numbers-mode)	; only show numbers in programming buffers
(setq display-line-numbers-type 'relative)		; relative line numbers

;; font size
(set-face-attribute 'default nil :family "Inconsolata" :height 130)

;; Line highlighting
(global-hl-line-mode 1)

;; Show matching parenthesis
(show-paren-mode 1)
;; Auto pair
(electric-pair-mode 1)

;; backup files to another folder
(setq backup-directory-alist `(("." . "~/.saves")))

;; auto revert remote files
(setq auto-revert-remote-files 1)

;; TRAMP
(setq tramp-default-method "ssh") ; use ssh by default

;; disable compilation warnings
(setq comp-async-report-warnings-errors nil)

;; helm mode
(helm-mode 1)

;; org mode
(setq org-export-coding-system 'utf-8)
; indent and hard wrapping
(with-eval-after-load 'org
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'auto-fill-mode) ; hard wrap
  (add-hook 'org-mode-hook 'turn-on-org-cdlatex)) 
(setq org-todo-keywords '((sequence "TODO(t)" "IN PROGRESS(p)" "|" "SKIPPED(s)" "DONE(d)")))
(setq org-directory "~/Sync/org") ; main org directory
(setq org-agenda-files '("~/Sync/org/agenda")) ; include all in folder as agenda
(setq org-agenda-span 17
      org-agenda-start-on-weekday nil
      org-agenda-start-day "-3d")
(setq org-agenda-category-icon-alist
      '(
	("tasks" ,"" nil nil :ascent center)
	("university" ,"" nil nil :ascent center)
	("birthdays" ,"" nil nil :ascent center)
	("reminders" ,"" nil nil :ascent center)
	("routine" ,"" nil nil :ascent center)
	))
(setq org-agenda-prefix-format '((agenda . "  %i %?-12t% s")
				 (todo . " %-15:c")
				 (tags . " %-15:c")
				 (search . " %-15:c")))
; TODO poner con general.el
(define-key global-map "\C-cc" 'org-capture)
;; configure org capture templates
(setq org-capture-templates
      '(("t"               ; hotkey
	 "Todo list item"  ; name
	 entry             ; type
					; heading type and title
	 (file+headline "~/Sync/org/agenda/tasks.org" "Tasks")
	 "* TODO %?\n %i\n %a") ; template
	("u"               ; hotkey
	 "University todo item"  ; name
	 entry             ; type
	 (file+headline "~/Sync/org/agenda/university.org" "Tasks")
	 "* TODO %?\n %i") ; template
	("r"
	 "Set reminder"
	 entry
	 (file+headline "~/Sync/org/agenda/reminders.org" "Reminders")
	 "* %?\n %i")
	("b"
	 "BibTex reference"
	 plain
	 (file "~/Sync/org/references.bib")
	 "%i\n\n")
	("d"
	 "Personal diary"
	 entry
	 (file+datetree "~/Sync/org/diary.org.gpg")
	 "** %^{Heading}")
      ))
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-superstar-special-todo-items 'hide)
(setq org-superstar-headline-bullets-list
      '("◉" "◈";; Stop cycling bullets to emphasize hierarchy of headlines.
(setq org-superstar-cycle-headline-bullets nil)
;; Hide away leading stars on terminal.
(setq org-superstar-leading-fallback ?\s) "○" "▷"))
(with-eval-after-load 'org-superstar
  (set-face-attribute 'org-superstar-item nil :height 1.0)
  (set-face-attribute 'org-superstar-header-bullet nil :height 1.0)
  (set-face-attribute 'org-superstar-leading nil :height 1.0))
;; org babel load languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   ))
;; org export
(require 'org-ref)
(setq org-latex-listings t)
(setq org-latex-caption-above nil)
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
	       '("org-plain-latex"
		 "\\documentclass[a4paper,11pt,titlepage]{scrbook}
		 [NO-DEFAULT-PACKAGES] [PACKAGES] [EXTRA]"
		 ("\\chapter{%s}" . "\\chapter*{%s}")
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		 ("\\paragraph{%s}" . "\\paragraph*{%s}")
		 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))
(require 'ox-reveal)
(setq org-reveal-root "file:///home/ramon/Documents/reveal.js")
(setq org-reveal-title-slide nil)
;; org roam
(require 'org-roam)
(setq org-roam-v2-ack t)
(setq org-roam-directory (file-truename "~/Sync/org/roam"))
(setq org-roam-db-location (file-truename "~/.org/roam.db"))
(setq org-roam-completion-everywhere t)
(require 'websocket)
(require 'simple-httpd)
(load-library "org-roam-ui")
(setq org-roam-ui-sync-theme t
      org-roam-ui-follow t
      org-roam-ui-update-on-save t
      org-roam-ui-open-on-start t)
(global-set-key (kbd "C-c r f") 'org-roam-node-find)
(global-set-key (kbd "C-c r c") 'org-roam-capture)
(global-set-key (kbd "C-c r i") 'org-roam-node-insert)
(global-set-key (kbd "C-c r t") 'org-roam-buffer-toggle)
(global-set-key (kbd "C-c r r") 'org-roam-ref-find)
(define-key org-mode-map (kbd "C-M-i") 'completion-at-point)
(org-roam-setup)
;; bibtex - TODO pdfs
(setq bibtex-completion-bibliography
      '("~/Sync/org/references.bib"))
(setq org-ref-default-bibliography
      '("~/Sync/org/references.bib"))
(setq org-latex-pdf-process
      (list "latexmk -shell-escape -bibtex -f -pdf %f"))
;; disable <> auto pairing in electric-pair-mode for org-mode
(add-hook
 'org-mode-hook
 (lambda ()
   (setq-local electric-pair-inhibit-predicate
               `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))

;; evil mode
(setq evil-want-C-u-scroll t)   ; use C-u to scroll up in normal mode
(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
(setq evil-want-Y-yank-to-eol t)
(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))
(require 'evil-numbers)
(define-key evil-normal-state-map (kbd "+") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "-") 'evil-numbers/dec-at-pt)
; (require 'evil-magit)
(require 'evil-nerd-commenter)
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)
(require 'evil-surround)
(global-evil-leader-mode)
(global-evil-surround-mode 1)
(evil-mode 1)
(evil-snipe-mode 1)

;; keybinds
(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"
  "'" '(term :which-key "iterm")
  ;; magit
  "m" '(magit :which-key "magit")
  ;; buffers
  "bn" '(evil-next-buffer :which-key "next buffer")
  "bp" '(evil-previous-buffer :which-key "previous buffer")
  "bd" '(evil-delete-buffer :which-key "delete buffer")
  "bb" '(helm-buffers-list :which-key "change buffer")
  ;; windows
  "wj" '(evil-window-down :which-key "window down")
  "wk" '(evil-window-up :which-key "window up")
  "wh" '(evil-window-left :which-key "window left")
  "wl" '(evil-window-right :which-key "window right")
  "ws" '(evil-window-split :which-key "window split")
  "wv" '(evil-window-vsplit :which-key "window vsplit")
  "wd" '(evil-window-delete :which-key "window delete")
  ;; tabs
  "tn" '(tab-new :which-key "tab new")
  "th" '(tab-previous :which-key "tab previous")
  "tl" '(tab-next :which-key "tab next")
  "tc" '(tab-close :which-key "tab close")
  ;; evil-commenter
  "ci" '(evilnc-comment-or-uncomment-lines :which-key "(un)comment line")
  "cl" '(evilnc-quick-comment-or-uncomment-to-the-line :which-key "(un)comment to the line")
  "cc" '(evilnc-copy-and-comment-lines :which-key "copy & comment")
  "cp" '(evilnc-comment-or-uncomment-paragraphs :which-key "(un)comment parahraphs")
  "cr" '(comment-or-uncomment-region :which-key "(un)comment region")
  "cv" '(evilnc-toggle-invert-comment-line-by-line :which-key "invert comment by line")
  "\\" '(evilnc-comment-operator :which-key "comment operator")
  ;; avy
  ";"  '(avy-goto-char-timer :which-key "avy char timer")
  ;; term
  "tt" '(term :which-key "shell")
  ;; folding
  "fo" '(origami-open-node :which-key "open fold")
  "fao" '(origami-open-all-nodes :which-key "open all folds")
  "fO" '(origami-open-node-recursively :which-key "open fold recursively")
  "fc" '(origami-close-node :which-key "open fold")
  "fac" '(origami-close-all-nodes :which-key "open all folds")
  "fC" '(origami-close-node-recursively :which-key "open fold recursively")
  "ft" '(origami-toggle-node :which-key "toggle fold")
  "fT" '(origami-toggle-node :which-key "toggle fold recursively")
  "ff" '(origami-show-only-node :which-key "fold everything except current")
  "fn" '(origami-next-fold :which-key "move to next fold")
  "fp" '(origami-previous-fold :which-key "move to previous fold")
  "fu" '(origami-undo :which-key "undo fold operation")
  "fr" '(origami-redo :which-key "redo fold operation")
  "fR" '(origami-reset :which-key "origami reset")
  ;; ...
)

;; Company
(require 'company)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "<tab>") nil)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))
(add-hook 'after-init-hook 'global-company-mode)
(define-key global-map (kbd "C-.") 'company-files)
(setq company-minimum-prefix-length 1
      company-idle-delay 0.2) ;; default is 0.2

;; Prescient
(require 'prescient)
(require 'company-prescient)
(prescient-persist-mode 1) ; remembering history between sessions
(company-prescient-mode 1)

;; undo-tree
(global-undo-tree-mode)

;; Yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.config/emacs/snippets" yasnippet-snippets-dir))
(yas-global-mode 1)

;; eglot
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)

;; tree-sitter
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(setq tree-sitter-debug-highlight-jump-region t)
(setq tree-sitter-debug-jump-buttons t)

;; helm mode
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list) ;; List buffers ( Emacs way )
(global-set-key (kbd "C-x r b") 'helm-bookmarks) ;; Bookmarks menu
(global-set-key (kbd "C-x C-f") 'helm-find-files) ;; Finding files with Helm
(global-set-key (kbd "M-c") 'helm-calcul-expression) ;; Use Helm for calculations
(global-set-key (kbd "C-s") 'helm-occur)  ;; Replaces the default isearch keybinding
(global-set-key (kbd "C-h a") 'helm-apropos)  ;; Helmized apropos interface
(global-set-key (kbd "M-y") 'helm-show-kill-ring)  ;; Show kill ring, pick something to pastelm-mode 1)

;; C-x is binded also to C-z because it makes dvorak usage a lot easier
(global-set-key (kbd "C-z") ctl-x-map)

;; which key
(require 'which-key)
(which-key-mode 1)

;; dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-init-info t)
(setq dashboard-projects-backend 'project-el)
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))
;; avy
(avy-setup-default)

;; modeline
;; for telephone-line configuration needs to be before (telephhone-line-mode 1)
(require 'telephone-line)
(setq telephone-line-primary-left-separator 'telephone-line-cubed-left
      telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
      telephone-line-primary-right-separator 'telephone-line-cubed-right
      telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)
(setq telephone-line-height 24)
(setq telephone-line-lhs
      '((evil   . (telephone-line-evil-tag-segment))
        (accent . (telephone-line-vc-segment
                   telephone-line-erc-modified-channels-segment
                   telephone-line-process-segment))
        (nil    . (telephone-line-buffer-segment
		   telephone-line-minor-mode-segment))))
(setq telephone-line-rhs
      '((nil    . (telephone-line-misc-info-segment))
        (accent . (telephone-line-major-mode-segment))
        (evil   . (telephone-line-airline-position-segment))))
(telephone-line-mode 1)

;; doom themes
(load-theme 'doom-gruvbox t)

;; pdf tools
(pdf-tools-install)
;; (evil-set-initial-state 'pdf-view-mode 'normal)

;; auctex
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)
; revert the PDF-buffer after the TeX compilation has finished
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;; scheme - SICM
(defun mechanics ()
  (interactive)
  (run-scheme 
    "/usr/local/bin/mit-scheme --library /usr/local/lib/mit-scheme-x86-64/"
  ))

;; elfeed
(require 'elfeed)
(setq elfeed-db-directory "~/Sync/.elfeed")
(require 'elfeed-org)
;; Initialize elfeed-org. This hooks up elfeed-org to read the
;; configuration when elfeed is started with =M-x elfeed=
(elfeed-org)
(setq rmh-elfeed-org-files (list "~/Sync/org/elfeed.org"))

;; rosemacs
;; (add-to-list 'load-path "/opt/ros/melodic/share/emacs/site-lisp")
;; (require 'rosemacs-config)
