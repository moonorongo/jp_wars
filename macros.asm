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
          
          lda            #$01      
          sta            sprcolor  ; jetpac color blanco

          lda            #$07      
          sta            sprcolorFire; fire color amarillo
          
          lda            #$02      
          sta            sprxpandX ; expandimos X el disparo.

          lda            #$21      
          sta            sprpoint  ; sprite 0 en $0840
          
          lda            #$22 
          sta            sprpointFire  ; sprite 0 en $0880

          lda            #$0       ; fire flag 0      
          sta            fire1     
          endm
          