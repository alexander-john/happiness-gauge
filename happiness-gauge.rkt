;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname happiness-gauge) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; HappinessLevel is a Number.
; interpretation represents the level of happiness

(define MIN 0) ; minimum happiness level
(define MAX 100) ; maximum happiness level

(define DCREASE-BY -0.1) ; with each clock tick,
; happiness decreases by

(define DOWN-ARROW-DCREASE 1/5) ; every time the
; down arrow key is pressed, happiness decreases by

(define UP-ARROW-INCREASE 1/3) ; every time the
; up arrow is pressed, happiness jumps by

(define WIDTH 100)
(define HEIGHT 10)
(define MTSCN (empty-scene WIDTH HEIGHT))

; HappinessLevel -> Image
; renders the level of happiness
(check-expect (render 10)
              (overlay/align "left" "middle" (rectangle 10 HEIGHT "solid" "red")
           MTSCN))
(define (render level)
  (overlay/align "left" "middle" (rectangle level HEIGHT "solid" "red")
           MTSCN))

; HappinessLevel -> HappinessLevel
; decreases level by DCREASE-BY
(check-expect (tock 10) (+ 10 DCREASE-BY))
(define (tock level)
  (+ level DCREASE-BY))

; HappinessLevel KeyEvent -> HappinessLevel
; when "down" is pressed, happiness decreases
; by 1/5; when "up" is pressed, happiness jumps by 1/3
(check-expect (update 10 "up") (+ 10 (* 10 UP-ARROW-INCREASE)))
(check-expect (update 10 "down") (- 10 (* 10 DOWN-ARROW-DCREASE)))
(check-expect (update 10 "left") 10)
(define (update level ks)
  (cond
    [(key=? ks "up") (+ level (* level UP-ARROW-INCREASE))]
    [(key=? ks "down") (- level (* level DOWN-ARROW-DCREASE))]
    [else level]))

; HappinessLevel -> HappinessLevel
; launches happiness gauge
(define (gauge-prog max)
  (big-bang max
    [to-draw render]
    [on-tick tock]
    [on-key update]))