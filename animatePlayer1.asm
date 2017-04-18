animatePlayer1
                                   ; -------------- STATUS 0 -------
          ldx            statusJP1 
          cpx            #0
          bne            @statusJP1_1
                                   ; INIT SPRITE JP1
          ldx            #50       ; posicionamos jetpac 1
          stx            sprx
          ldx            #0        ; que salga desde arriba de la pantalla...
          stx            spry      
          lda            #ptrJPRight      
          sta            sprpoint  ; jet pac 1 mirando a la derecha
                        
          ldx            #1        
          stx            statusJP1 
          
@statusJP1_1                       ; -------------- STATUS 1 -----------------
                                   
          ldx            statusJP1 
          cpx            #1        
          bne            @statusJP1_2
          
          inc            spry      
          ldy            spry      
          cpy            #50       
          beq            @set_statusJP1_2
          
          jmp            @exit     
          
@set_statusJP1_2
          ldx            #2
          stx            statusJP1 
          
          
@statusJP1_2                       ; -------------- STATUS 2 ----------------------------
          ldx            statusJP1 
          cpx            #2        
          beq            @chkUp
      
          jmp            @statusJP_3
          
@jmpNext  jmp            @next
@chkUp
          lda            joy2      
          cmp            #127      
          beq            @jmpNext  ; avoid +- 127 bytes jmp long

          ldx            JP1Jet    ; check si hay fuel 
          cpx            #$0       
          beq            @chkLeft  ; si no hay pasa de largo... adiooos

          lda            joy2      
          and            #1        ; up
          bne            @chkLeft
          jsr            checkTopP1 ; solo sube si no llego al tope
          cpx            #1        
          beq            @chkLeft
          
          dec            spry      
          
          lda            tick64
          cmp            #0
          beq            @chkLeft  ; cada 64 frames gasta combustible
          dec            JP1Jet    ; gasta combustible

@chkLeft  lda            joy2      
          and            #4        ; left
          bne            @chkRight  
          
          jsr            checkFloorP1 ; solo se mueve si esta volando
          cpx            #1      
          beq            @chkRight  

          lda            #ptrJPLeft      
          sta            sprpoint  
          dec            sprx      
          
@chkRight lda            joy2      
          and            #8        ; right
          bne            @chkFire   
          
          jsr            checkFloorP1 ; solo se mueve si esta volando
          cpx            #1      
          beq            @chkFire  

          lda            #ptrJPRight      
          sta            sprpoint  
          inc            sprx      

@chkFire  lda            joy2      
          and            #16       ; fire
          bne            @next
          
          ldx            fire1     
          cpx            #0        
          bne            @next      ; checkeo si ya disparo
          
          lda            #1        ; setea status fire1 
          sta            fire1     
          
          lda            spractive  ; los sprites que esten activos
          ora            #%00000010 ; activo sprite 2 (disparo P1)
          sta            spractive  ;activamos el disparo
          
;         end check joystick          
          

@next
          ldx            gravityCounter
          dex
          stx            gravityCounter
          cpx            #$0       
          bne            @exit
          
          jsr            checkFloorP1
          
          cpx            #1      ; check floor (si result checkFloorP1 es 1 es el piso)
          beq            @skipGravity
          
         
          inc            spry      ; gravity :P 

@skipGravity
          ldx            #gravity
          stx            gravityCounter
          
          jmp            @exit     
          
          
@statusJP_3                       ; --------------- STATUS 3 -----------------
             
          ldx            gravityCounter
          dex
          stx            gravityCounter
          cpx            #$0       
          bne            @exit
          ldx            #gravity
          stx            gravityCounter

          lda            tick4
          cmp            #0
          beq            @skipIncFallCounter ; cada 4 frames va  a incrementar fallCounter
          
          inc            fallCounter
          
@skipIncFallCounter          
          lda            spry      
          adc            fallCounter
          sta            spry      ;cae JP1 vertiginosamente (cada vez mas)
          
          ldx            fallCounter 
          dex                           ; uso fallCounter como contador de frames (pero necesito que sea -1)
          cpx            #4             ; hasta que llegue a 4 (animacion de 5 frames, no mas)
          beq            @explodeEnded  ; si es igual, que no asigne ningun puntero mas...
          
          txa
          adc            #ptrJPExplode
          sta            sprpoint  
          
@explodeEnded          
          ldx            sprpoint2   
          cpx            #ptrJPRight  ; si esta mirando a la derecha
          bne            @decxspr2    ; decrementa sprx
         
          ldx            sprx       
          inx                      ; si mira a la izq incrementa
          stx            sprx      
          jmp            @chkFloor  
          
@decxspr2 
          ldx            sprx      
          dex                      ; decrementa si mira a la derecha
          stx            sprx      
          
          
@chkFloor
          jsr            checkFloorP1
          cpx            #1        
          bne            @exit
          
          ldx            #0      
          stx            fallCounter

          ldx            #0        
          stx            statusJP1 
          

@exit          
          jsr            updateJP1Jet
          
;          lda            tick4
;          cmp            #0        
;          beq            @exit2    
;          ldx            seed      
;          stx            $d020

;@exit2
          rts
; ------------- end of main animatePlayer1 ---------------------------                




; verifica posicion Y de P1, y retorna 1 en X si es el piso 
checkFloorP1
          clc
          ldx            spry      
          cpx            #floorPosition
          beq            @returnTrue    ; is equal
          bcs            @returnTrue    ; or greater ;) 
          ldx            #0        
          rts
@returnTrue
          ldx            #1        
          rts
          

; verifica posicion Y de P1, y retorna 1 en X si es el top
checkTopP1
          ldx            spry      
          cpx            #topPosition
          beq            @returnTrue    ; is equal
          ;bcs            @returnTrue    ; or greater ;) 
          ldx            #0        
          rts
@returnTrue
          ldx            #1        
          rts
          








; muestra los hits del jetpac 1
updateJP1hits
          lda            JP1hits   
          jsr            convert2ascii
          sty            $053d
          stx            $053e
          sta            $053f
          rts
          
; actualiza el medidor de JET de JP1
updateJP1Jet
          lda            JP1Jet   
          jsr            convert2ascii
          sty            $0565
          stx            $0566
          sta            $0567
          rts
