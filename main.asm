*         = $1000
        
          initVars

main_loop
          jsr            animatePlayer1
          jsr            animatePlayer1Fire
          
          waitrt
          jmp            main_loop 
          
exit
          rts                      ; BASIC
          