#lang racket

; don't run this file for testing: it launches the GUI
(module test racket/base)

(require "Players/player.rkt")
(require "Players/strategy.rkt")
(require "Referee/referee.rkt")
(require "Referee/observer.rkt")
(require (submod "Common/state.rkt" examples))

(define players
  (list (player-new "Alice" riemann-strategy)
        (player-new "Bob"   euclidean-strategy)
        (player-new "Carol" riemann-strategy)))

(define obs (observer-new))

(run-game players gamestate5 (list obs))
