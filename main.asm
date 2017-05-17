*         = $1000
        
          copyScreen
          jsr initVars

          
main_loop
          jsr            randomGenerator
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
          