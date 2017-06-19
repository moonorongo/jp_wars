*         = $1000
main
;          jsr main_menu

start_game
          ldx            #<screen
          stx            lsbCopyAddress
          ldx            #>screen
          stx            msbCopyAddress
          jsr            copyToScreen

          ldx            #<colour
          stx            lsbCopyAddress
          ldx            #>colour
          stx            msbCopyAddress
          jsr            copyToScreenColor
          
          jsr initVars

          
main_loop
          jsr            animatePlayer1
          jsr            animatePlayer1Fire
          jsr            animatePlayer2
          jsr            animatePlayer2Fire
          jsr            detectCollision
          jsr            tickGenerator
          jsr            animateFuel

          waitrt
          jmp            main_loop 
          
exit
          rts                      ; BASIC
          