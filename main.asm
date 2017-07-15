// BasicUpstart2: esta macro genera codigo en BASIC para iniciar el programa
BasicUpstart2(main)

/*
    JetPac Wars! Main File
*/

// Includes
#import "sprites.asm"
#import "vars.asm"
#import "macros.asm"

          *         = $1000 "Main Program"
main:
            jmp            main_menu

start_game:

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
          
main_loop:
#import "animatePlayer1.asm"
#import "animatePlayer1Fire.asm"

/* quitar los rts en todo lo que este en el loop... por ejm en animatePlayer1Fire hay 2, uno al ppio y el otro al fin */

            jsr            animatePlayer2
            jsr            animatePlayer2Fire
            jsr            detectCollision
            jsr            tickGenerator
            
            
            
            jsr            animateFuel
          
            jsr            checkEndGame         // devuelve en Y si termino la partida
            cpy            #1        
            beq            goto_mainmenu


            waitrt()
            jmp            main_loop 
goto_mainmenu:
            jmp            main_menu 
          
exit:
          rts                      // BASIC
          

/*
    Subrutinas
*/
#import "functions_p1.asm"          
//#import "functions_p2.asm"          

#import "animatePlayer2.asm"
#import "animatePlayer2Fire.asm"
#import "detectCollision.asm"
#import "screen.asm"
#import "screen_colour.asm"
#import "menu_screen.asm"
#import "tickGenerator.asm"
#import "fuel.asm"
#import "initVars.asm"
#import "main_menu.asm"

#import "functions.asm"
