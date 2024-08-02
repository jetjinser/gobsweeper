(import
  (scheme base)
  (only (hoot primitives) define*)
  (only (hoot numbers) 1+ 1-)
  (only (hoot bitwise) logand)
  (hoot ffi))

(define-foreign random
  "math" "random"
  i32 -> i32)

; TODO: export set
(define board-size 9)
(define mine-count 10)

(define ready #b000)
(define opened #b010)
(define flagged #b100)

(define safe #b000)
(define mine #b001)

(define (block-ready? board x y)
  (= (logand (board-ref/wrap board x y) #b110) ready))

(define (block-opened? board x y)
  (= (logand (board-ref/wrap board x y) #b110) opened))

(define (block-flagged? board x y)
  (= (logand (board-ref/wrap board x y) #b110) flagged))

(define (block-safe? board x y)
  (= (logand (board-ref/wrap board x y) #b001) safe))

(define (block-mine? board x y)
  (= (logand (board-ref/wrap board x y) #b001) mine))

(define* (bytevector-u8-fill! bv value
                           #:optional
                           (start 0)
                           (end (bytevector-length bv)))
  (do ([i start (1+ i)])
      ([> i (1- end)])
    (bytevector-u8-set! bv i value)))

(define (bytevector-swap! bv i j)
  (let ([t (bytevector-u8-ref bv i)])
    (bytevector-u8-set! bv i (bytevector-u8-ref bv j))
    (bytevector-u8-set! bv j t)))

;; Fisher–Yates shuffle
(define (bytevector-shuffle! bv)
  (let loop ([bv-index (bytevector-length bv)])
    (unless (= bv-index 0)
      (let ([j (random bv-index)]
            [next-bv-index (- bv-index 1)])
        (bytevector-swap! bv next-bv-index j)
        (loop next-bv-index)))))

(define (make-board)
  (let* ([block-count (* board-size board-size)]
         [bv (make-bytevector block-count)])
    (bytevector-u8-fill! bv mine (- block-count mine-count))
    (bytevector-shuffle! bv)
    bv))

(define the-board (make-board))

(define (board-ref board x y)
  (bytevector-u8-ref board (+ (* y board-size) x)))

(define (board-ref/wrap board x y)
  (bytevector-u8-ref board (+ (* (modulo y board-size) board-size)
                              (modulo x board-size))))

(define (board-set! board x y t)
  (bytevector-u8-set! board (+ (* y board-size) x) t))

(define (board-neighbors board x y)
  (define (check x y)
    (if (block-mine? board x y) 1 0))
  (+ (check (- x 1) (- y 1))
     (check x (- y 1))
     (check (+ x 1) (- y 1))
     (check (+ x 1) y)
     (check (+ x 1) (+ y 1))
     (check x (+ y 1))
     (check (- x 1) (+ y 1))
     (check (- x 1) y)))

(define (ref x y)
  (board-ref the-board x y))

(define (set x y t)
  (board-set! the-board x y t))

(define (mine? x y)
  (block-mine? the-board x y))

(define (neighbors x y)
  (board-neighbors the-board x y))

(define (uncover x y)
  (cond
    [(mine? x y) -1]
    [else (neighbors x y)]))

(values ref set uncover)
