defm      waitrt
          ldx            skiprt    
          cpx            #$00
          bne            @next     
          ldx            #$03      
          stx            skiprt    
          
@loop     ldx            raster
          cpx            #$0       
          bne            @loop     
@next     
          dec            skiprt    
          endm

defm      initVars
          lda            #$00      ; borde y fondo negro
          sta            cborde     
          sta            cfondo


          lda            #$03      ; inicializo skiprt (conteo hasta hacer un wait retrace)
          sta            skiprt
          

          ldx            #172      ; posicionamos jetpac
          stx            sprx
          ldx            #139       
          stx            spry
          

          ldx            #196      ; posicionamos disparo
          stx            sprxFire
          ldx            #139       
          stx            spryFire
            
          lda            #$01      
          sta            spractive ;activamos el sprite 0 
          
          lda            #$0d
          sta            sprcolor  ; jetpac color verde claro

          lda            #$0a
          sta            sprcolorFire; fire color amarillo

;          lda            #$03      
;          sta            sprcolor  ; jetpac2 color cyan

; ambos disparen light red

          lda            #$02      
          sta            sprxpandX ; expandimos X el disparo.

          lda            #$21      
          sta            sprpoint  ; sprite 0 en $0840
          
          lda            #$22 
          sta            sprpointFire  ; sprite 0 en $0880

          lda            #$0       ; fire flag 0      
          sta            fire1     
          
          lda            #gravity
          sta            gravityCounter
          
          endm



defm      copyScreen
          ldx            #$00      
@loop          
          lda            screen,x  
          sta            scrPtr,x  

          lda            screen + $100,x  
          sta            scrPtr + $100,x  

          lda            screen + $200,x  
          sta            scrPtr + $200,x  

          lda            screen + $300,x  
          sta            scrPtr + $300,x  
          
          lda            colour,x  
          sta            scrColPtr,x

          lda            colour + $100,x  
          sta            scrColPtr + $100,x
          
          lda            colour + $200,x  
          sta            scrColPtr + $200,x
          
          lda            colour + $300,x  
          sta            scrColPtr + $300,x
          
          inx
          cpx            #$00       
          bne            @loop     
          endm
          