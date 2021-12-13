(in-package :solutions)

(defvar *input* (utils:get-problem-input-int (format nil "~A~A"
                                                     *default-pathname-defaults*
                                                     "../input/day-1.txt")))

(defun part-a ()
  (let* ((raw-answer (reduce (lambda (acc v)
                               (let* ((last-v  (car acc))
                                      (counter (cadr acc)))
                                 (if (and (not (null last-v)) (> v last-v))
                                     (list v (1+ counter))
                                     (list v counter))))
                             *input*
                             :initial-value (list nil 0))))
    (first raw-answer)))

(defun window-sum (window)
  (reduce #'+ window))

(defun inc-tally-p (window prv-sum)
  (and (or (and (not (null prv-sum))
                (> (window-sum window) prv-sum))
           (null prv-sum))
       (equal 3 (length window))))

(defun next-window (window next-v)
  (if (< (length window) 3)
      (append window (list next-v))
      (append (rest window) (list next-v))))

(defun part-b ()
  (let* ((tally 0)
         (prv-sum nil))
    (reduce (lambda (acc v)
              (if (null acc)
                  (list v)
                  (progn
                    (if (inc-tally-p acc prv-sum) (setf tally (1+ tally)))
                    (setf prv-sum (window-sum acc))
                    (next-window acc v))))
            *input*
            :initial-value nil)
    tally))
