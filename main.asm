*         = $1000
main
          jmp            main_menu 

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
          
          jsr            initVars  

          
main_loop
          jsr            animatePlayer1
          jsr            animatePlayer1Fire
          jsr            animatePlayer2
          jsr            animatePlayer2Fire
          jsr            detectCollision
          jsr            tickGenerator
          jsr            animateFuel
          
          jsr            checkEndGame ; devuelve en Y si termino la partida
          cpy            #1        
          beq            goto_mainmenu

          waitrt
          jmp            main_loop 

goto_mainmenu
          jmp            main_menu 
          
exit
          rts                      ; BASIC
          