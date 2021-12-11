(in-package :solutions)

(defvar *input* (utils:get-problem-input "input/day-1.txt"))

;; answer: 1557
(defun part-a ()
  (let* ((raw-answer (reduce (lambda (acc v)
                               (let* ((last-v  (car acc))
                                      (counter (cadr acc)))
                                 (if (and (not (equal nil last-v)) (> v last-v))
                                     (list v (1+ counter))
                                     (list v counter))))
                             (map 'list #'parse-integer *input*)
                             :initial-value (list nil 0))))
    (cadr raw-answer)))

