(defpackage :utils
  (:use #:cl)
  (:export :get-input :get-input-int))

(defpackage :solutions
  (:use #:cl)
  (:import-from :utils))
