;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Ramón Calvo González"
      user-mail-address "noctrog@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
; test
(setq doom-font (font-spec :family "monospace" :size 14)
      doom-variable-pitch-font (font-spec :family "sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-gruvbox)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/.org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; (defun my/python-mode-hook ()
;;   (add-to-list 'company-backends 'company-jedi))

;; (add-hook 'python-mode-hook 'my/python-mode-hook)

;; scroll margin
(setq scroll-margin 4)
(setq maximum-scroll-margin 4.25)

;; configura lsp
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; configura el undo persistente
(setq undo-tree-auto-save-history 'true)

;; usa lsp-ui para mostrar los errores
(setq lsp-prefer-flymake 'false)

;; Aniade la clase para exportar Latex usada para los apuntes
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))

(add-to-list 'org-latex-classes '("apuntes_clase"
                                  "\\documentclass[11pt]{book}"
;; \\usepackage{listings}
;; \\usepackage{color}

;; \\definecolor{mygreen}{rgb}{0,0.6,0}
;; \\definecolor{mygray}{rgb}{0.5,0.5,0.5}
;; \\definecolor{mymauve}{rgb}{0.58,0,0.82}

;; \\lstset{
;;   backgroundcolor=\\color{white},   % choose the background color; you must add \\usepackage{color} or \\usepackage{xcolor}; should come as last argument
;;   basicstyle=\\footnotesize,        % the size of the fonts that are used for the code
;;   breakatwhitespace=false,         % sets if automatic breaks should only happen at whitespace
;;   breaklines=true,                 % sets automatic line breaking
;;   captionpos=b,                    % sets the caption-position to bottom
;;   commentstyle=\\color{mygreen},    % comment style
;;   deletekeywords={...},            % if you want to delete keywords from the given language
;;   escapeinside={\\%*}{*)},          % if you want to add LaTeX within your code
;;   extendedchars=true,              % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8
;;   firstnumber=1000,                % start line enumeration with line 1000
;;   frame=single,	                   % adds a frame around the code
;;   keepspaces=true,                 % keeps spaces in text, useful for keeping indentation of code (possibly needs columns=flexible)
;;   keywordstyle=\\color{blue},       % keyword style
;;   language=c,                 % the language of the code
;;   morekeywords={*,...},            % if you want to add more keywords to the set
;;   numbers=left,                    % where to put the line-numbers; possible values are (none, left, right)
;;   numbersep=5pt,                   % how far the line-numbers are from the code
;;   numberstyle=\\tiny\\color{mygray}, % the style that is used for the line-numbers
;;   rulecolor=\\color{black},         % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))
;;   showspaces=false,                % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
;;   showstringspaces=false,          % underline spaces within strings only
;;   showtabs=false,                  % show tabs within strings adding particular underscores
;;   stepnumber=2,                    % the step between two line-numbers. If it's 1, each line will be numbered
;;   stringstyle=\\color{mymauve},     % string literal style
;;   tabsize=2,	                   % sets default tabsize to 2 spaces
;;   title=\\lstname                   % show the filename of files included with \\lstinputlisting; also try caption instead of title"
  ("\\chapter{%s}" . "\\chapter*{%s}")
  ("\\section{%s}" . "\\section*{%s}")
  ("\\subsection{%s}" . "\\subsection*{%s}")
  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
  ("\\paragraph{%s}" . "\\paragraph*{%s}")))
(add-to-list 'org-latex-classes '("article" "\\documentclass[11pt]{article}"
  ("\\section{%s}" . "\\section*{%s}")
  ("\\subsection{%s}" . "\\subsection*{%s}")
  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
  ("\\paragraph{%s}" . "\\paragraph*{%s}")
  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes '("report" "\\documentclass[11pt]{report}"
  ("\\part{%s}" . "\\part*{%s}")
  ("\\chapter{%s}" . "\\chapter*{%s}")
  ("\\section{%s}" . "\\section*{%s}")
  ("\\subsection{%s}" . "\\subsection*{%s}")
  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
(add-to-list 'org-latex-classes '("book" "\\documentclass[11pt]{book}"
  ("\\part{%s}" . "\\part*{%s}")
  ("\\chapter{%s}" . "\\chapter*{%s}")
  ("\\section{%s}" . "\\section*{%s}")
  ("\\subsection{%s}" . "\\subsection*{%s}")
  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
