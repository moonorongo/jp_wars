*         = $1000
        
; no cambiar el orden de estas llamadas!
; (copyScreen pisa la inicializacion de los punteros de sprites)
          copyScreen
          initVars

main_loop
          jsr            animatePlayer1
          jsr            animatePlayer1Fire
          jsr            animatePlayer2
          
          waitrt
          jmp            main_loop 
          
exit
          rts                      ; BASIC
          