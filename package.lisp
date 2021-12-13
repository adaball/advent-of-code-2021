(defpackage :utils
  (:use #:cl)
  (:export :get-problem-input :get-problem-input-int))

(defpackage :solutions
  (:use #:cl)
  (:import-from :utils))
