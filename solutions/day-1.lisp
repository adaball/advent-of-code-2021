(in-package :solutions)

(defvar *input* (map 'list #'parse-integer (utils:get-problem-input "input/day-1.txt")))

;; answer: 1557
(defun part-a ()
  (let* ((raw-answer (reduce (lambda (acc v)
                               (let* ((last-v  (car acc))
                                      (counter (cadr acc)))
                                 (if (and (not (equal nil last-v)) (> v last-v))
                                     (list v (1+ counter))
                                     (list v counter))))
                             *input*
                             :initial-value (list nil 0))))
    (cadr raw-answer)))

(defun next-sum-higher-p (seq-one seq-two)
  (let ((sum-one (reduce #'+ seq-one))
        (sum-two (reduce #'+ seq-two)))
    (> sum-two sum-one)))

(defun update-window (window next-val compare-window)
  (if (equal (list (length window) (length compare-window)) '(3 3))
      (list )))

(defun part-b ()
  (reduce (lambda (acc v)
            (if (equal '(nil nil nil 0) acc)
                (append (list v) '(nil) '(nil) '(0))
                (let* ((wind-a (car acc))
                       (wind-b (caar acc))
                       (wind-c (caaar acc))
                       (next-a v)
                       (next-b (if (equal wind-a nil) nil v))
                       (next-c (if (equal wind-b nil) nil v)))
                  (list (if (and (equal (length wind-a) 3) (equal (length wind-c) 3))
                            nil nil)))))
          *input*
          :initial-value (list nil nil nil 0)))


;; 3 measurement sliding windows
;; 199  A 
;; 200  A B
;; 208  A B C 
;; 210    B C D
;; 200  E   C D
;; 207  E F   D
;; 240  E F G 
;; 269    F G H
;; 260      G H
;; 263        H

;; 199 A 
;; 200 A B
;; 208 A B C
;; 210   B C A
;; 200     C A B
;; 207       A B C
;; 240         B C A
;; 269           C A B
;; 260             A B C
;; 263               B C A

;; (nil     nil     nil)     -> ((A)     nil     nil    )
;; ((A)     nil     nil)     -> ((A A)   (B)     nil    )
;; ((A A)   (B)     nil)     -> ((A A A) (B B)   (C)    )
;; ((A A A) (B B)   (C))     -> ((A)     (B B B) (C C)  )
;; ((A)     (B B B) (C C))   -> ((A A)   (B)     (C C C)) 
;; ((A A)   (B)     (C C C)) -> ((A A A) (B B)   (C)    )

;; init (nil     nil     nil)
;; 199  ((A)     nil     nil)
;; 200  ((A A)   (B)     nil)    
;; 208  ((A A A) (B B)   (C))    
;; 210  ((A)     (B B B) (C C))
;; 200  ((A A)   (B)     (C C C))
;; 207  ((A A A) (B B)   (C))

;; input -> compare prev with current, inc counter -> 



;; find the number of increases in the SUM of each COMPLETE sliding window
;; when compared with the last COMPLETE sliding window
;; start out with 3 empty lists (windows)
;; if the first is empty, add v to it
;; if the second is empty and the first isn't, add v to both first and second
;; if the third is empty and the first and second aren't, add v to all three

;; if the first is full, compare to third (if full), empty third if full
;; if the second is full, compare second to first, empty first
;; if the third is full, compare third to second, empty second
;;
;; F -> first, S -> second, T -> third
;; F - nil, S - F, T - S,
;; F - T,   S - F, T - S,
;; ...
;; 
