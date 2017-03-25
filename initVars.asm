initVars
          cld                      ; clear decimal flag.
          
          lda            #$00      ; borde y fondo negro
          sta            cborde     
          sta            cfondo


          lda            #$03      ; inicializo skiprt (conteo hasta hacer un wait retrace)
          sta            skiprt
          
          ldx            #0        ; contador hits jetpac 1 y 2
          stx            JP1hits   
          stx            JP2hits   
          
          ldx            #50      ; posicionamos jetpac 1
          stx            sprx
          ldx            #139       
          stx            spry

          ldx            #150      ; posicionamos jetpac 2
          stx            sprx2
          ldx            #139       
          stx            spry2
          
          ldx            #196      ; posicionamos disparo 1
          stx            sprxFire
          ldx            #139       
          stx            spryFire

          ldx            #196      ; posicionamos disparo 2
          stx            sprxFire2
          ldx            #139       
          stx            spryFire2

          lda            #$05      
          sta            spractive ;activamos el sprite 0 y 2
          
          lda            #$0d
          sta            sprcolor  ; jetpac 1 color verde claro
          
          lda            #$03
          sta            sprcolor2  ; jetpac 2 color cyan

          lda            #$02
          sta            sprcolorFire  ; fire color red
          sta            sprcolorFire2  ; fire color red

          lda            #$0a      
          sta            sprxpandX ; expandimos X el disparo 1 y 2.

          lda            #ptrJPRight      
          sta            sprpoint  ; jet pac 1 mirando a la derecha

          lda            #ptrJPLeft
          sta            sprpoint2  ; jet pac 1 mirando a la izquierda
          
          lda            #ptrJPFire      
          sta            sprpointFire  
          sta            sprpointFire2  ; punteros de disparo

          lda            #$0       ; fire flag 
          sta            fire1     
          sta            fire2     
          
          lda            #gravity
          sta            gravityCounter
          sta            gravityCounter2
          
          jsr            updateJP1hits
          jsr            updateJP2hits
          
          

          rts
          
          