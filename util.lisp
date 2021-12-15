(in-package :utils)

(defun get-problem-input (pathspec)
  "Read the advent problem input.  For some reason, using `with-open-file`
was causing PATHSPEC to be erased in some cases.  There's likely a reason
for it, but I didn't want to dig around."
  (let* ((is (open pathspec :direction :input :if-does-not-exist :error))
         (lines (with-open-file (is pathspec :if-does-not-exist :error)
                  (loop :for line = (read-line is nil nil)
                        :while line
                        :collect line))))
    (close is)
    lines))

(defun input-sym-to-path (file-sym)
  (format nil "input/~(~A~).txt" file-sym))

(defun get-input (file-sym)
  (get-problem-input (input-sym-to-path file-sym)))

(defun get-input-int (file-sym)
  (map 'list #'parse-integer (get-input file-sym)))
