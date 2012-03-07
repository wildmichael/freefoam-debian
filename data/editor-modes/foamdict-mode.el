;;; foamdict-mode.el --- Major mode for OpenFOAM/FreeFOAM data files

;; Author:     2009 Michael Wild
;; Author:     2002 Martin Stjernholm
;; Maintainer: Michael Wild
;; Created:    December 2009
;; Version:    0.1
;; Keywords:   OpenFOAM FreeFOAM data

;;-------------------------------------------------------------------------------
;;               ______                _     ____          __  __
;;              |  ____|             _| |_  / __ \   /\   |  \/  |
;;              | |__ _ __ ___  ___ /     \| |  | | /  \  | \  / |
;;              |  __| '__/ _ \/ _ ( (| |) ) |  | |/ /\ \ | |\/| |
;;              | |  | | |  __/  __/\_   _/| |__| / ____ \| |  | |
;;              |_|  |_|  \___|\___|  |_|   \____/_/    \_\_|  |_|
;;
;;                   FreeFOAM: The Cross-Platform CFD Toolkit
;;
;; Copyright (C) 2008-2012 Michael Wild <themiwi@users.sf.net>
;;                         Gerber van der Graaf <gerber_graaf@users.sf.net>
;;-------------------------------------------------------------------------------
;; License
;;  This file is part of FreeFOAM.
;;
;;  FreeFOAM is free software: you can redistribute it and/or modify it
;;  under the terms of the GNU General Public License as published by the
;;  Free Software Foundation, either version 3 of the License, or (at your
;;  option) any later version.
;;
;;  FreeFOAM is distributed in the hope that it will be useful, but WITHOUT
;;  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;;  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;;  for more details.
;;
;;  You should have received a copy of the GNU General Public License
;;  along with FreeFOAM.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;; This is derived from <http://cc-mode.sourceforge.net/derived-mode-ex.el>.
;; It is very rudimentary and doesn't change much beyond renaming the mode.
;;
;; Note: The interface used in this file requires CC Mode 5.30 or
;; later.

;;; Code:

(require 'cc-mode)

;; These are only required at compile time to get the sources for the
;; language constants.  (The cc-fonts require and the font-lock
;; related constants could additionally be put inside an
;; (eval-after-load "font-lock" ...) but then some trickery is
;; necessary to get them compiled.)
(eval-when-compile
  (require 'cc-langs)
  (require 'cc-fonts))

(eval-and-compile
  ;; Make our mode known to the language constant system.  Use Java
  ;; mode as the fallback for the constants we don't change here.
  ;; This needs to be done also at compile time since the language
  ;; constants are evaluated then.
  (c-add-language 'foamdict-mode 'c-mode))

;; FOAMDict has no boolean but a string and a vector type.
;(c-lang-defconst c-primitive-type-kwds
;  foamdict (append '("string" "vector")
;                   (delete "boolean"
;                           ;; Use append to not be destructive on the
;                           ;; return value below.
;                           (append
;                             ;; Due to the fallback to Java, we need not give
;                             ;; a language to `c-lang-const'.
;                             (c-lang-const c-primitive-type-kwds)
;                             nil))))

;; Function declarations begin with "function" in this language.
;; There's currently no special keyword list for that in CC Mode, but
;; treating it as a modifier works fairly well.
;(c-lang-defconst c-modifier-kwds
;  foamdict (cons "function" (c-lang-const c-modifier-kwds)))

;; No cpp in this language, but there's still a "#include" directive to
;; fontify.  (The definitions for the extra keywords above are enough
;; to incorporate them into the fontification regexps for types and
;; keywords, so no additional font-lock patterns are required.)
(c-lang-defconst c-cpp-matchers
  foamdict (cons
      ;; Use the eval form for `font-lock-keywords' to be able to use
      ;; the `c-preprocessor-face-name' variable that maps to a
      ;; suitable face depending on the (X)Emacs version.
      '(eval . (list "^\\s *\\(#include\\)\\>\\(.*\\)"
         (list 1 c-preprocessor-face-name)
         '(2 font-lock-string-face)))
      ;; There are some other things in `c-cpp-matchers' besides the
      ;; preprocessor support, so include it.
      (c-lang-const c-cpp-matchers)))

(defcustom foamdict-font-lock-extra-types nil
  "*List of extra types (aside from the type keywords) to recognize in FOAMDict mode.
Each list item should be a regexp matching a single identifier.")

(defconst foamdict-font-lock-keywords-1 (c-lang-const c-matchers-1 foamdict)
  "Minimal highlighting for FOAMDict mode.")

(defconst foamdict-font-lock-keywords-2 (c-lang-const c-matchers-2 foamdict)
  "Fast normal highlighting for FOAMDict mode.")

(defconst foamdict-font-lock-keywords-3 (c-lang-const c-matchers-3 foamdict)
  "Accurate normal highlighting for FOAMDict mode.")

(defvar foamdict-font-lock-keywords foamdict-font-lock-keywords-3
  "Default expressions to highlight in FOAMDict mode.")

(defvar foamdict-mode-syntax-table nil
  "Syntax table used in foamdict-mode buffers.")
(or foamdict-mode-syntax-table
    (setq foamdict-mode-syntax-table
    (funcall (c-lang-const c-make-mode-syntax-table foamdict))))

;(defvar foamdict-mode-abbrev-table nil
;  "Abbreviation table used in foamdict-mode buffers.")
;(c-define-abbrev-table 'foamdict-mode-abbrev-table
;  ;; Keywords that if they occur first on a line might alter the
;  ;; syntactic context, and which therefore should trig reindentation
;  ;; when they are completed.
;  '(("else" "else" c-electric-continued-statement 0)
;    ("while" "while" c-electric-continued-statement 0)
;    ("catch" "catch" c-electric-continued-statement 0)
;    ("finally" "finally" c-electric-continued-statement 0)))

;(defvar foamdict-mode-map (let ((map (c-make-inherited-keymap)))
;          ;; Add bindings which are only useful for FOAMDict
;          map)
;  "Keymap used in foamdict-mode buffers.")

(easy-menu-define foamdict-menu foamdict-mode-map "FOAMDict Mode Commands"
      ;; Can use `foamdict' as the language for `c-mode-menu'
      ;; since its definition covers any language.  In
      ;; this case the language is used to adapt to the
      ;; nonexistence of a cpp pass and thus removing some
      ;; irrelevant menu alternatives.
      (cons "FOAMDict" (c-lang-const c-mode-menu foamdict)))

;;;###autoload
(add-to-list 'auto-mode-alist '("Dict\\'" . foamdict-mode))

;;;###autoload
(defun foamdict-mode ()
  "Major mode for editing OpenFOAM and FreeFOAM data files..

Key bindings:
\\{foamdict-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (c-initialize-cc-mode t)
  (set-syntax-table foamdict-mode-syntax-table)
  (setq major-mode 'foamdict-mode
  mode-name "FOAMDict"
  local-abbrev-table foamdict-mode-abbrev-table
  abbrev-mode t)
  (use-local-map c-mode-map)
  ;; `c-init-language-vars' is a macro that is expanded at compile
  ;; time to a large `setq' with all the language variables and their
  ;; customized values for our language.
  (c-init-language-vars foamdict-mode)
  ;; `c-common-init' initializes most of the components of a CC Mode
  ;; buffer, including setup of the mode menu, font-lock, etc.
  ;; There's also a lower level routine `c-basic-common-init' that
  ;; only makes the necessary initialization to get the syntactic
  ;; analysis and similar things working.
  (c-common-init 'foamdict-mode)
  (easy-menu-add foamdict-menu)
  (run-hooks 'c-mode-common-hook)
  (run-hooks 'foamdict-mode-hook)
  (c-update-modeline))


(provide 'foamdict-mode)

;;; foamdict-mode.el ends here

