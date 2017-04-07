animatePlayer2
                                   ; -------------- STATUS 0 -------
          ldx            statusJP2 
          cpx            #0
          bne            @statusJP2_1
                                   ; INIT SPRITE JP2
          ldx            #233      ; posicionamos jetpac 2
          stx            sprx2
          ldx            #0        ; que salga desde arriba de la pantalla...
          stx            spry2     
          lda            #ptrJPLeft      
          sta            sprpoint2  ; jet pac 2 mirando a la izquierda
                        
          ldx            #1        
          stx            statusJP2 
          
@statusJP2_1                       ; -------------- STATUS 1 -----------------
                                   
          ldx            statusJP2 
          cpx            #1        
          bne            @statusJP2_2
          
          inc            spry2      
          ldy            spry2      
          cpy            #50       
          beq            @set_statusJP2_2
          
          jmp            @exit     
          
@set_statusJP2_2
          ldx            #2
          stx            statusJP2
          
          
@statusJP2_2                       ; -------------- STATUS 2 -----------------------
          ldx            statusJP2
          cpx            #2        
          beq            @chkTop
      
          jmp            @statusJP2_3
          
@jmpNext  jmp            @next
@chkTop
          lda            joy1      
          cmp            #127      
          beq            @jmpNext  ; avoid +- 127 bytes jmp long

          lda            joy1      
          and            #1        ; up
          bne            @chkLeft
          jsr            checkTopP2 ; solo sube si no llego al tope
          cpx            #1        
          beq            @chkLeft
          
          dec            spry2      

@chkLeft  lda            joy1      
          and            #4        ; left
          bne            @chkRight  
          
          jsr            checkFloorP2 ; solo se mueve si esta volando
          cpx            #1      
          beq            @chkRight  

          lda            #ptrJPLeft      
          sta            sprpoint2  
          dec            sprx2      
          
@chkRight lda            joy1      
          and            #8        ; right
          bne            @chkFire   
          
          jsr            checkFloorP2 ; solo se mueve si esta volando
          cpx            #1      
          beq            @chkFire  

          lda            #ptrJPRight      
          sta            sprpoint2  
          inc            sprx2      

@chkFire  lda            joy1      
          and            #16       ; fire
          bne            @next
          
          ldx            fire2     
          cpx            #0        
          bne            @next      ; checkeo si ya disparo
          
          lda            #1        ; setea status fire1 
          sta            fire2     
          
          lda            spractive  ; los sprites que esten activos
          ora            #%00001000 ; activo sprite 4 (disparo P2)
          sta            spractive  ;activamos el disparo
          
;         end check joystick          
          

@next
          ldx            gravityCounter2
          dex
          stx            gravityCounter2
          cpx            #$0       
          bne            @exit
          
          jsr            checkFloorP2
          cpx            #1      
          beq            @skipGravity
          
         
          inc            spry2      ; gravity :P 

@skipGravity
          ldx            #gravity
          stx            gravityCounter2
          
          jmp            @exit     
          
          
@statusJP2_3                       ; --------------- STATUS 3 -----------------
             
          ldx            gravityCounter2
          dex
          stx            gravityCounter2
          cpx            #$0       
          bne            @exit
          ldx            #gravity
          stx            gravityCounter2


          lda            tick4
          cmp            #0
          beq            @skipIncFallCounter ; cada 4 frames va  a incrementar fallCounter

          inc            fallCounter2
          
@skipIncFallCounter          
          lda            spry2
          adc            fallCounter2
          sta            spry2
          
          ldx            fallCounter2 
          dex                           ; uso fallCounter como contador de frames (pero necesito que sea -1)
          cpx            #4             ; hasta que llegue a 4 (animacion de 5 frames, no mas)
          beq            @explodeEnded  ; si es igual, que no asigne ningun puntero mas...
          
          txa
          adc            #ptrJPExplode
          sta            sprpoint2
          
@explodeEnded          
          ldx            sprpoint
          cpx            #ptrJPRight  ; si esta mirando a la derecha
          bne            @decxspr2    ; decrementa sprx
         
          lda            sprx2
          adc            #2 ; si mira a la izq incrementa
          sta            sprx2      
          jmp            @chkFloor  
          
@decxspr2 
          lda            sprx2     
          sbc            #2
          sta            sprx2      
          
          
@chkFloor
          jsr            checkFloorP2
          cpx            #1        
          bne            @exit
          
          ldx            #0      
          stx            fallCounter2

          ldx            #0        
          stx            statusJP2
          

@exit                             
          rts
; ------------- end of main animatePlayer2 ---------------------------                




; verifica posicion Y de P2, y retorna 1 en X si es el piso 
checkFloorP2
          clc
          ldx            spry2
          cpx            #floorPosition
          beq            @returnTrue    ; is equal
          bcs            @returnTrue    ; or greater ;) 
          ldx            #0        
          rts
@returnTrue
          ldx            #1        
          rts
          

; verifica posicion Y de P2, y retorna 1 en X si es el top
checkTopP2
          ;clc   ;verificar si la operacion me pone carry o me lo quita...
          ldx            spry2
          cpx            #topPosition
          beq            @returnTrue    ; is equal
          ;bcs            @returnTrue    ; or greater ;) 
          ldx            #0        
          rts
@returnTrue
          ldx            #1        
          rts
          

; muestra los hits del jetpac 2
updateJP2hits
          lda            JP2hits   
          jsr            convert2ascii
          sty            $0655
          stx            $0656
          sta            $0657
          rts