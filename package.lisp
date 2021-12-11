(defpackage :utils
  (:use #:cl)
  (:export :get-problem-input))

(defpackage :solutions
  (:use #:cl)
  (:import-from :utils))
