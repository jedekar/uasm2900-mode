(defgroup uasm2900-mode ()
  "Options for `uasm2900-mode'."
  :group 'languages)

(defgroup uasm2900-mode-faces ()
  "Faces used by `uasm2900-mode'."
  :group 'uasm2900-mode)

(defface uasm2900-signals
  '((t :inherit (font-lock-constant-face)))
  "Face for signals."
  :group 'uasm2900-mode-faces)

(defface uasm2900-inputs
  '((t :inherit (font-lock-constant-face)))
  "Face for signals."
  :group 'uasm2900-mode-faces)

(defface uasm2900-registers
  '((t :inherit (font-lock-variable-name-face)))
  "Face for registers."
  :group 'uasm2900-mode-faces)

(defface uasm2900-instructions
  '((t :inherit (font-lock-builtin-face)))
  "Face for instructions."
  :group 'uasm2900-mode-faces)

(defface uasm2900-directives
  '((t :inherit (font-lock-keyword-face)))
  "Face for directives."
  :group 'uasm2900-mode-faces)

(defface uasm2900-labels
  '((t :inherit (font-lock-function-name-face)))
  "Face for labels."
  :group 'uasm2900-mode-faces)

(defface uasm2900-constant
  '((t :inherit (font-lock-constant-face)))
  "Face for constant."
  :group 'uasm2900-mode-faces)

(eval-and-compile
  (defconst uasm2900-signals
    '("cem_c" "cem_n" "cem_v" "cem_z" "ci" "co" "ct" "int"
      "irq0" "irq1" "irq2" "irq3" "irq4" "irq5" "irq6" "irq7"
      "lock" "no" "nz" "rdd" "rdm" "rm_c" "rm_z" "rm_v" "rm_n" "vo" "z" "zo")
    "uASM2900 signals for `uasm2900-mode'."))

(eval-and-compile
  (defconst uasm2900-inputs
    '("ev" "ewa" "ewb" "ewh" "ewl" "l1" "l2" "l3" "l4" "l5" "l6"
      "i" "o" "oey" "r" "w")
    "uASM2900 inputs for `uasm2900-mode'."))

(eval-and-compile
  (defconst uasm2900-registers
    '("bus_d" "dev_buf" "inr" "ir" "irq" "mr" "nil" "ra" "rb" "r0" "r1"
      "r2" "r3" "r4" "r5" "r6" "r7" "r8" "r9" "r10" "r11" "r12" "r13" "r14"
      "r15" "rq" "rm" "rn" "vec")
    "uASM2900 registers for `uasm2900-mode'."))

(eval-and-compile
  (defconst uasm2900-directives
    '("accept" "dw" "equ" "include" "link" "macro" "org")
    "uASM2900 directives for `uasm2900-mode'."))

(eval-and-compile
  (defconst uasm2900-instructions
    '("add" "and" "cjp" "cjs" "clr" "cont" "crtn" "flags" "inc" "jmap" "jmp"
      "jz" "load" "nand" "not"  "nxor" "or" "read" "sla" "sll" "sl.25" "sra"
      "srl" "sr.9" "sub" "xor")
    "uASM2900 instructions for `uasm2900-mode'."))

(defconst uasm2900-label-rexexp
  "\\(\\_<[a-zA-Z_?][a-zA-Z0-9_$#@~?]*\\_>\\)"
  "Regexp for `uasm2900-mode' for matching labels.")

(defconst uasm2900-constant-regexp
  "\\<$?[-+]?[0-9][-+_0-9A-Fa-fHhXxDdTtQqOoBbYyeE.%]*\\>"
  "Regexp for `uasm2900-mode' for matching numeric constants.")

(defmacro uasm2900--opt (keywords)
  "Prepare KEYWORDS for `looking-at'."
  `(eval-when-compile
     (regexp-opt ,keywords 'words)))

(defconst uasm2900-font-lock-keywords
  `((,(uasm2900--opt uasm2900-signals) . 'uasm2900-signals)
    (,(uasm2900--opt uasm2900-inputs) . 'uasm2900-inputs)
    (,(uasm2900--opt uasm2900-registers) . 'uasm2900-registers)
    (,(uasm2900--opt uasm2900-instructions) . 'uasm2900-instructions)
    (,uasm2900-constant-regexp . 'uasm2900-constant)
    (,(uasm2900--opt uasm2900-directives) . 'uasm2900-directives)
    (,(concat "^\\s-*" uasm2900-label-rexexp) (1 'uasm2900-labels)))
  "Keywords for `uasm2900-mode'.")

(defconst uasm2900-mode-syntax-table
  (with-syntax-table (copy-syntax-table)
    (modify-syntax-entry ?_  "_")
    (modify-syntax-entry ?#  "_")
    (modify-syntax-entry ?@  "_")
    (modify-syntax-entry ?\? "_")
    (modify-syntax-entry ?~  "_")
    (modify-syntax-entry ?\. "w")
    (modify-syntax-entry ?\\ "<")
    (modify-syntax-entry ?\n ">")
    (modify-syntax-entry ?\" "\"")
    (modify-syntax-entry ?\' "\"")
    (modify-syntax-entry ?\` "\"")
    (syntax-table))
  "Syntax table for `uasm2900-mode'.")

;;;###autoload
(define-derived-mode uasm2900-mode prog-mode "AM2900"
  "Major mode for editing AM2900 uassembly programs."
  :group 'uasm2900-mode
  (make-local-variable 'comment-start)
  (setf font-lock-defaults '(uasm2900-font-lock-keywords nil :case-fold)
        comment-start "\\"))

(provide 'uasm2900-mode)
