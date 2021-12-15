(in-package :solutions)

(defvar *input-2* (utils:get-input :day-2))

(defun tokenize-string (s delim)
  "It's silly that Common Lisp doesn't have a string split
function and you have to roll your own.  Yet somehow that's also
very \"Common Lisp\" of them to just give you the parts to make it
instead of giving you the thing you actually need.

Anyhow, I copied this one from:

http://cl-cookbook.sourceforge.net/strings.html#reverse"
  (loop :for i = 0 then (1+ j)
        :as j = (position delim s :start i)
        :collect (subseq s i j)
        :while j))

(defun process-input (input)
  "Make a list of lists out of the raw list-of-strings input,
spliting on `#\Space`"
  (map 'list (lambda (v)
               (let* ((tokens (tokenize-string v #\Space)))
                 (list (first tokens) (parse-integer (second tokens)))))
       input))

(defun problem-2a ()
  (let* ((raw-res 
           (reduce (lambda (acc v)
                     (let* ((direction (first v))
                            (amount (second v)))
                       (cond
                         ((string= "up" direction) (setf (cdr acc) (- (cdr acc) amount)))
                         ((string= "down" direction) (setf (cdr acc) (+ (cdr acc) amount)))
                         ((string= "forward" direction) (setf (car acc) (+ (car acc) amount))))
                       acc))
                   (process-input *input-2*)
                   :initial-value (cons 0 0))))
    (* (car raw-res) (cdr raw-res))))
