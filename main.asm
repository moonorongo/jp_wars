// BasicUpstart2: esta macro genera codigo en BASIC para iniciar el programa
BasicUpstart2(main)

/*
    JetPac Wars! Main File
*/

// Includes
#import "sprites.asm"
#import "vars.asm"
#import "macros.asm"

            * = $1000 "Main Program"
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
#import "sound_fire1.asm"
#import "animatePlayer1Fire.asm"
#import "animatePlayer2.asm"
#import "sound_fire2.asm"
#import "animatePlayer2Fire.asm"
#import "detectCollision.asm"
#import "tickGenerator.asm"
#import "fuel.asm"
          
            jsr            checkEndGame         // devuelve en Y si termino la partida
            cpy            #1        
            beq            goto_mainmenu

#import "wait_retrace.asm"

            jmp            main_loop 
goto_mainmenu:
            jmp            main_menu 
          
exit:
          rts                      // BASIC
          

/*
    Subrutinas
*/
#import "functions_p1.asm"          
#import "functions_p2.asm"          
#import "functions.asm"
#import "initVars.asm"

/*
    Pantallas
*/    
#import "screen.asm"
#import "screen_colour.asm"
#import "menu_screen.asm"

/*
    Main Menu 
*/    
#import "main_menu.asm"

