;;
;;  LowH Triangle
;;
;;  Copyright 2014 LowH <code@lowh.net>
;;
;;  Permission to use, copy, modify, and distribute this software for any
;;  purpose with or without fee is hereby granted, provided that the above
;;  copyright notice and this permission notice appear in all copies.
;;
;;  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
;;  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
;;  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
;;  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
;;  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
;;  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
;;  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
;;

(in-package :cl-user)

(defpackage :RoL-log
  (:nicknames :L>log)
  (:use :cl)
  (:export
   #:*log-output*
   #:log-msg
   #:with-logged-warnings))

(in-package :RoL-log)

(defvar *log-output* *error-output*)

(defun log-msg (level fmt &rest args)
  (let ((*print-case* :upcase)
        (*print-pretty* nil))
    (format *log-output* "~&~A ~?~%" level fmt args)
    (force-output *log-output*)))

(defmacro with-logged-warnings (&body body)
  `(handler-bind ((warning
                   (lambda (w)
                     (log-msg :warn "~A" w)
                     (muffle-warning w))))
     ,@body))
