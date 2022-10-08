#lang racket

;;; This module provides data definitions and logic for the gems that appear on tiles

;; --------------------------------------------------------------------
;; MODULE INTERFACE

(require racket/contract)

(provide
 (contract-out
  [gem? contract?]
  [gems (listof gem?)]))


;; --------------------------------------------------------------------
;; DATA DEFINITIONS

;; A Gem is a symbol, enumerated in gems
;; interpretation: The name of a precious gem
(define gems (list
              'alexandrite-pear-shape
              'alexandrite
              'almandine-garnet
              'amethyst
              'ametrine
              'ammolite
              'apatite
              'aplite
              'apricot-square-radiant
              'aquamarine
              'australian-marquise
              'aventurine
              'azurite
              'beryl
              'black-obsidian
              'black-onyx
              'black-spinel-cushion
              'blue-ceylon-sapphire
              'blue-cushion
              'blue-pear-shape
              'blue-spinel-heart
              'bulls-eye
              'carnelian
              'chrome-diopside
              'chrysoberyl-cushion
              'chrysolite
              'citrine-checkerboard
              'citrine
              'clinohumite
              'color-change-oval
              'cordierite
              'diamond
              'dumortierite
              'emerald
              'fancy-spinel-marquise
              'garnet
              'golden-diamond-cut
              'goldstone
              'grandidierite
              'gray-agate
              'green-aventurine
              'green-beryl-antique
              'green-beryl
              'green-princess-cut
              'grossular-garnet
              'hackmanite
              'heliotrope
              'hematite
              'iolite-emerald-cut
              'jasper
              'jaspilite
              'kunzite-oval
              'kunzite
              'labradorite
              'lapis-lazuli
              'lemon-quartz-briolette
              'magnesite
              'mexican-opal
              'moonstone
              'morganite-oval
              'moss-agate
              'orange-radiant
              'padparadscha-oval
              'padparadscha-sapphire
              'peridot
              'pink-emerald-cut
              'pink-opal
              'pink-round
              'pink-spinel-cushion
              'prasiolite
              'prehnite
              'purple-cabochon
              'purple-oval
              'purple-spinel-trillion
              'purple-square-cushion
              'raw-beryl
              'raw-citrine
              'red-diamond
              'red-spinel-square-emerald-cut
              'rhodonite
              'rock-quartz
              'rose-quartz
              'ruby-diamond-profile
              'ruby
              'sphalerite
              'spinel
              'star-cabochon
              'stilbite
              'sunstone
              'super-seven
              'tanzanite-trillion
              'tigers-eye
              'tourmaline-laser-cut
              'tourmaline
              'unakite
              'white-square
              'yellow-baguette
              'yellow-beryl-oval
              'yellow-heart
              'yellow-jasper
              'zircon
              'zoisite))

(define gem? (apply or/c gems))