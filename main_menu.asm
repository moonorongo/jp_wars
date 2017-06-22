main_menu
          ldx            #0
          stx            cborde
          ldx            #2
          stx            cfondo  

          lda            #0      
          sta            spractive ;desactivamos todos los sprites
  

          ldx            #<menu_screen
          stx            lsbCopyAddress
          ldx            #>menu_screen
          stx            msbCopyAddress
          jsr            copyToScreen

          ldx            #<menu_color
          stx            lsbCopyAddress
          ldx            #>menu_color
          stx            msbCopyAddress
          jsr            copyToScreenColor
          
@loop
          ldx            $CB       ; current key pressed, $40 no key
          cpx            #$04      ; if F1
          beq            @go_main  

          inc            $d021
          
          jmp            @loop     

@go_main
          jmp            start_game
          


        
  