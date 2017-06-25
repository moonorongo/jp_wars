main_menu
          ldx            #0
          stx            cborde
          ldx            #1
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
          
          ldy #0

@loop 
          ldx            $CB       ; current key pressed, $40 no key
          cpx            #$04      ; if F1
          beq            @go_main  

          lda            color_ramp,y


@loop_raster
          ldx            raster    
@r_line   cpx            #$0
          bne            @loop_raster
          
          inc            @r_line+1 ; incrementa posicion de comparacion
          inc            @r_line+1 ; incrementa posicion de comparacion
          inc            @r_line+1 ; incrementa posicion de comparacion
          inc            @r_line+1 ; incrementa posicion de comparacion
          inc            @r_line+1 ; incrementa posicion de comparacion
          inc            @r_line+1 ; incrementa posicion de comparacion
          inc            @r_line+1 ; incrementa posicion de comparacion
          inc            @r_line+1 ; incrementa posicion de comparacion
          inc            @r_line+1 ; incrementa posicion de comparacion
          inc            @r_line+1 ; incrementa posicion de comparacion
          inc            @r_line+1 ; incrementa posicion de comparacion
          inc            @r_line+1 ; incrementa posicion de comparacion
          sta            $d021     
          
          iny
          cpy            #7        
          bne            @skip     
          ldy            #0        
          
@skip          

          jmp            @loop     

@go_main
          jmp            start_game
          


        
  

color_ramp
          BYTE 7, 10, 8, 2, 9, 2, 8, 10
          

