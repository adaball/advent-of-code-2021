(in-package :solutions)

(defvar *input-3* (utils:get-input :day-3))
(defvar *width* (length (first *input-3*)))

;; power consumption = gamma rate * epsilon rate
;; gamma rate = most common bit in a col
;; epsilon rate = least common bit in a col

;; 00100
;; 11110
;; 10110
;;
;; col 0: 1 is most common, 0 is least common
;; col 1: 0 is most common, 1 is least common
;; col 2: 1 is most common, 0 is least common
;; col 3: 1 is most common, 0 is least common
;; col 4: 0 is most common, 1 is least common
;;
;; most common:  10110
;; least common: 01001



;; read strings from the col into a list
;; find the most common bit
;; append to result list
;; take complete result list, feed to make-array to make a bit array
;; XOR with a bit array of equal length but made of only 1's
;; result will be the bit array of the least common

;; convert bit arrays to strings of the same value, then convert those strings to integers
;; multiply them together
;; (defun tokenize-string (s delim)
;;   "It's silly that Common Lisp doesn't have a string split
;; function and you have to roll your own.  Yet somehow that's also
;; very \"Common Lisp\" of them to just give you the parts to make it
;; instead of giving you the thing you actually need.

;; Anyhow, I copied this one from:

;; http://cl-cookbook.sourceforge.net/strings.html#reverse"
;;   (loop :for i = 0 then (1+ j)
;;         :as j = (position delim s :start i)
;;         :collect (subseq s i j)
;;         :while j))

(defun problem-3a ()
  (let* ((bit-columns (loop for i from 0 to (1- *width*)
                            collect (map-to-nth-digit *input-3* i)))
         (m-common-bits (map 'list #'most-common bit-columns))
         (ba (make-array (length m-common-bits) :element-type 'bit :initial-contents m-common-bits)))
    ba))

(defun most-common (bit-list)
  (let* ((table (reduce (lambda (acc v) 
                          (let* ((k (parse-integer v))
                                 (new-v (1+ (gethash k acc 0))))
                            (setf (gethash k acc) new-v)
                            acc))
                        bit-list
                        :initial-value (make-hash-table))))
    (reduce (lambda (acc v)
              ;; (format t "~&comparing -> table[~A]: ~A~Ttable[~A]: ~A" acc (gethash acc table) v (gethash v table))
              (if (> (gethash v table) (gethash acc table)) v acc))
            '(1 0))))

(defun map-to-nth-digit (l n)
  (map 'list (lambda (v)
               (if (>= n (length v))
                   nil
                   (subseq v n (1+ n))))
       l))

(defun bin-str->int (bs)
  (parse-integer bs :radix 2))

(defun ba->string (ba)
  (reduce (lambda (acc v) (format nil "~A~A" acc v))
          ba 
          :initial-value ""))
