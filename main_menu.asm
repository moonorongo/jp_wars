main_menu:
{
          ldx            #0             
          stx            cborde
          ldx            #1             // establecemos colores de 
          stx            cfondo         // borde y fondo

          lda            #0      
          sta            spractive      // desactivamos todos los sprites
  

          ldx            #<menu_screen
          stx            lsbCopyAddress
          ldx            #>menu_screen
          stx            msbCopyAddress 
          jsr            copyToScreen       // copiamos pantalla

          ldx            #<menu_color
          stx            lsbCopyAddress
          ldx            #>menu_color
          stx            msbCopyAddress
          jsr            copyToScreenColor  // y colores 
          
          ldy #0

loop:
//          ldx            $CB       // que tecla se esta pulsando, $40 = ninguna
//          cpx            #$04      // si pulso F1
//          beq            go_main   // comienzo el juego
          
          lda            joy1       // si pulso disparo 1
          and            #16           
          beq            go_main
          lda            joy2       // o disparo 2
          and            #16           
          beq            go_main    // comienza el juego

          lda            color_ramp,y   // tomamos el color de la 
                                        // tabla de colores que vamos 
                                        // a ciclar

loop_raster:
          ldx            raster    
r_line:   cpx            #$0         // posicion de comparacion (r_line + 1)
          bne            loop_raster
                                     // esto es mejorable... 
          inc            r_line+1    // incrementa posicion de comparacion
          inc            r_line+1    // esto lo que hace es engrosar la linea
          inc            r_line+1    // de fondo
          inc            r_line+1    // es algo asi como codigo automodificable
          inc            r_line+1    // si quitan algunos de estos inc
          inc            r_line+1    // se afina la linea
          inc            r_line+1    // si agregan se engrosa
          inc            r_line+1 
          inc            r_line+1 
          inc            r_line+1 
          inc            r_line+1 
          inc            r_line+1 
          sta            cfondo      // establezco el color de fondo    
          
          iny                        // tomo el proximo color de la rampa
          cpy            #7          
          bne            skip     
          ldy            #0          // y ciclo si llego al final de la rampa
          
skip:          
          jmp            loop     

go_main:
          jmp            start_game
}          


        
  
// colores que voy a ir ciclando en el fondo
color_ramp:
          .byte 7, 10, 8, 2, 9, 2, 8, 10
          

