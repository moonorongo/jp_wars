animatePlayer1
          lda            joy2      
          cmp            #127      
          beq            @next      

          lda            joy2      
          and            #1        ; up
          bne            @chkDown   
          jsr            checkTopP1 ; solo sube si no llego al tope
          cpx            #1        
          beq            @chkDown   
          
          dec            spry      

@chkDown  lda            joy2      
          and            #2        ; down
          bne            @chkLeft   
          
          jsr            checkFloorP1 ; solo baja si no esta en el piso
          cpx            #1      
          beq            @chkLeft 
          
          inc            spry      
  
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
          
          
@exit
          rts
; ------------- end of main animatePlayer1 ---------------------------                


; verifica posicion Y de P1, y retorna 1 en X si es el piso 
checkFloorP1
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

