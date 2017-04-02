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
          beq            @chkTop
      
          jmp            @statusJP_3
          
@jmpNext  jmp            @next
@chkTop
          lda            joy2      
          cmp            #127      
          beq            @jmpNext  ; avoid +- 127 bytes jmp long

          lda            joy2      
          and            #1        ; up
          bne            @chkLeft
          jsr            checkTopP1 ; solo sube si no llego al tope
          cpx            #1        
          beq            @chkLeft
          
          dec            spry      

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

          inc            fallCounter
          lda            spry      
          adc            fallCounter
          sta            spry      
          
          ldx            sprpoint2   
          cpx            #ptrJPRight  ; si esta mirando a la derecha
          bne            @decxspr2    ; decrementa sprx
         
          lda            sprx       
          adc            fallCounter  ; si mira a la izq incrementa
          sta            sprx      
          jmp            @chkFloor  
          
@decxspr2 
          lda            sprx      
          sbc            fallCounter
          sta            sprx      
          
          
@chkFloor
          jsr            checkFloorP1
          cpx            #1        
          bne            @exit
          
          ldx            #0      
          stx            fallCounter

          ldx            #0        
          stx            statusJP1 
          

@exit                             
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
          





;hitJP1Animation
;          ldx            sprpoint2
;          cpx            #ptrJPRight
;          bne            @decxspr2 
          
;          inc            sprx      
;          inc            sprx      
;          inc            sprx     
;          jmp            @exit     
          
;@decxspr2          
;          dec            sprx      
;          dec            sprx      
;          dec            sprx     
          
;@exit          
;          rts





; muestra los hits del jetpac 1
updateJP1hits
          lda            JP1hits   
          jsr            convert2ascii
          sty            $053d
          stx            $053e
          sta            $053f
          rts