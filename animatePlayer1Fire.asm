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

          lda            sprx      
          adc            #12
          sta            sprxFire
          
          ldx            #ptrJPRight
          stx            dirFire   
          jmp            @loop     
          
          
@setDirFireLeft
          lda            sprx      
          sbc            #36
          sta            sprxFire

          ldx            #ptrJPLeft
          stx            dirFire             
          
@loop
          
          ldx            dirFire   
          cpx            #ptrJPLeft
          beq            @decrementFire
          
          lda            sprxFire  
          clc
          adc            #$02 ; cantidad de pixels que aumenta
          sta            sprxFire  
          bcs            @setStatus0
          jmp            @next     

@decrementFire
          lda            sprxFire   
          sec
          sbc            #$02 ; cantidad de pixels que decrementa
          sta            sprxFire  
          bcc            @setStatus0
          jmp            @next     

          
@setStatus0          
          ldx            #$0       ; si no seteo flag en 0
          stx            fire1     
          lda            #$01      
          sta            spractive ; desactivamos el sprite 1 
          
@next          
          rts
          
