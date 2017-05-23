initVars
          cld                      ; clear decimal flag.
          
          lda            #$00      ; borde y fondo negro
          sta            cborde     
          sta            cfondo


          lda            #skiprtCant      ; inicializo skiprt (conteo hasta hacer un wait retrace)
          sta            skiprt
          
          ldx            #0        ; contador hits jetpac 1 y 2
          stx            JP1hits   
          stx            JP2hits   
          
          ldx            #0        
          stx            statusJP1 
          stx            statusJP2

          ldx            #0        ; utilizado en animacion de JP1 cuando muere
          stx            fallCounter
          stx            fallCounter2
          
          lda            #$05      
          sta            spractive ;activamos el sprite 0 y 2
          
          lda            #$05 
          sta            sprcolor  ; jetpac 1 color verde
          
          lda            #$03
          sta            sprcolor2  ; jetpac 2 color cyan

          lda            #$02
          sta            sprcolorfuel  ; color combustible


          lda            #$02
          sta            sprcolorFire  ; fire color red
          sta            sprcolorFire2  ; fire color red

          lda            #$0a      
          sta            sprxpandX ; expandimos X el disparo 1 y 2.

          lda            #ptrJPLeft
          sta            sprpoint2  ; jet pac 1 mirando a la izquierda
          
          lda            #ptrJPFire      
          sta            sprpointFire  
          sta            sprpointFire2; punteros de disparo
          
          lda            #ptrFuel  
          sta            sprpointfuel

          lda            #$0       ; fire flag 
          sta            fire1     
          sta            fire2     
          
          lda            #gravity
          sta            gravityCounter
          sta            gravityCounter2
          
          jsr            updateJP1hits
          jsr            updateJP2hits
          
          
          ldx            #0        
          stx            internalCounter
          stx            tick4     
          stx            tick64

          ldx            #$80       
          stx            JP1Jet    
          stx            JP2Jet    
          

          ldx            $a0         ; inicializamos el generador de numeros aleatorios
          stx            random      ; con un valor de la variable TI (que esta en $a0)
          
          ldx            #0        
          stx            statusFuel
          
          ldx            #delayEntreFuels
          stx            fuelCounter

          rts
          
          