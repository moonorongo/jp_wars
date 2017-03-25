animatePlayer2
          lda            joy1    
          cmp            #127      
          beq            @next      

          lda            joy1
          and            #1        ; up
          bne            @chkDown   
          jsr            checkTopP2 ; solo sube si no llego al tope
          cpx            #1        
          beq            @chkDown   
          
          dec            spry2

@chkDown  lda            joy1
          and            #2        ; down
          bne            @chkLeft   
          
          jsr            checkFloorP2 ; solo baja si no esta en el piso
          cpx            #1      
          beq            @chkLeft 
          
          inc            spry2
  
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
          ora            #%00001000 ; sprite 4 (disparo P2)
          sta            spractive  ;activamos el disparo
          
;         end check joystick          
          

@next
          ldx            gravityCounter2
          dex
          stx            gravityCounter2
          cpx            #$0       
          bne            @exit
          
          jsr            checkFloorP2
          
          cpx            #1      ; check floor (si result checkFloorP1 es 1 es el piso)
          beq            @skipGravity
          
         
          inc            spry2      ; gravity :P 

@skipGravity
          ldx            #gravity
          stx            gravityCounter2
          
          
@exit
          rts
; ------------- end of main animatePlayer1 ---------------------------                


; verifica posicion Y de P1, y retorna 1 en X si es el piso 
checkFloorP2
          ldx            spry2
          cpx            #floorPosition
          beq            @returnTrue    ; is equal
          bcs            @returnTrue    ; or greater ;) 
          ldx            #0        
          rts
@returnTrue
          ldx            #1        
          rts
          

; verifica posicion Y de P1, y retorna 1 en X si es el top
checkTopP2
          ldx            spry2
          cpx            #topPosition
          beq            @returnTrue    ; is equal
          ;bcs            @returnTrue    ; or greater ;) 
          ldx            #0        
          rts
@returnTrue
          ldx            #1        
          rts
          



hitJP2Animation
          ldx            sprpoint  
          cpx            #ptrJPRight
          bne            @decxspr2 
          
          inc            sprx2      
          inc            sprx2      
          inc            sprx2     
          jmp            @exit     
          
@decxspr2          
          dec            sprx2      
          dec            sprx2      
          dec            sprx2     
          
@exit          
          rts
          



; muestra los hits del jetpac 2
updateJP2hits
          lda            JP2hits   
          jsr            convert2ascii
          sty            $0655
          stx            $0656
          sta            $0657
          rts