animatePlayer1Fire
          ldx            fire1     
          cpx            #$0       
          bne            @initFire
          rts                      ; vuelve si status fire es 0
          
@initFire
          ldx            fire1     
          cpx            #$1       
          bne            @loop     
                                   ; init fire (status 1)          
          ldx            spry
          stx            spryFire  

          inc            fire1     ; paso a status 2 (disparando)
        
          ldx            sprpoint  
          cpx            #ptrJPLeft
          beq            @setDirFireLeft
           
          ldx            #ptrJPRight
          stx            dirFire   

          lda            sprxBit8  
          and            #1        
          cmp            #1        
          bne            @jp1Bit8Off

          jsr            invertBit8
          
@jp1Bit8Off
          clc
          lda            sprx      
          adc            #12       
          sta            sprxFire  
          bcs            @setB8    
          jmp            @loop     
          
@setB8    jsr            invertBit8
          jmp            @loop     

; movimiento disparo hacia la izquierda          
@setDirFireLeft
          ldx            #ptrJPLeft
          stx            dirFire   

          lda            sprxBit8  
          and            #1        
          cmp            #1        
          bne            @jp1Bit8Off_2
          
          lda            sprxBit8  
          ora            #%00000010
          sta            sprxBit8  

@jp1Bit8Off_2          
          sec
          lda            sprx      
          sbc            #36
          sta            sprxFire  
          bcc            @unsetB8
          
          jmp            @loop     
          
@unsetB8  jsr            invertBit8

@loop
          ldx            dirFire   
          cpx            #ptrJPLeft       
          beq            @decrementFire
          
          lda            sprxBit8  
          and            #2        
          cmp            #2
          beq            @bit8On   ; si el bit8 esta prendido voy a checkear si llego al borde
          
          ; Bit 8 apagado
          clc
          lda            sprxFire 
          adc            #$02      ; cantidad de pixels que aumenta
          sta            sprxFire 
          bcs            @setB8_2 
          jmp            @next    
          
@setB8_2  jsr            invertBit8
          jmp            @next     
          
@bit8On
          clc
          lda            sprxFire  
          adc            #2        ; cantidad de pixels que aumenta
          sta            sprxFire  
          cmp            #90       ; borde de la pantalla
          bcs            @setStatus0
          jmp            @next     

@decrementFire
          lda            sprxBit8  
          and            #2        
          cmp            #2
          beq            @bit8On_2 ; si el bit8 esta prendido voy a checkear si llego a 0 
          
          ; Bit 8 apagado
          sec
          lda            sprxFire 
          sbc            #$02
          sta            sprxFire 
          bcc            @setStatus0
          jmp            @next    

@bit8On_2
          sec
          lda            sprxFire   
          sbc            #$02 ; cantidad de pixels que decrementa
          sta            sprxFire  
          bcc            @setB8_2 
          jmp            @next     
          
@setStatus0          
          jsr            turnOffFire1
          
@next          
          rts
          




; invert Bit 8 de disparo JP1
invertBit8
          lda            sprxBit8       
          eor            #2             
          sta            sprxBit8       
          rts


; turn off fire player 1
turnOffFire1
          ldx            #$0       ; si no seteo flag en 0
          stx            fire1     
          
          lda            spractive  ; los sprites que esten activos
          and            #255 - FJP1 ; apago disparo P1
          sta            spractive ; desactivamos el disparo
          
          lda            sprxBit8    ; apago bit 8      
          and            #%11111101 
          sta            sprxBit8       

          rts
          