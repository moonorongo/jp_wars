animatePlayer2Fire
          ldx            fire2
          cpx            #$0       
          bne            @initFire
          rts                      ; vuelve si status fire es 0
          
@initFire
          ldx            fire2     
          cpx            #$1       
          bne            @loop     
                                   ; init fire (status 1)          
          ldx            spry2
          stx            spryFire2

          inc            fire2     ; paso a status 2 (disparando)
          
          ldx            sprpoint2
          cpx            #ptrJPLeft
          beq            @setDirFireLeft

          lda            sprx2
          adc            #12
          sta            sprxFire2
          
          ldx            #ptrJPRight
          stx            dirFire2
          jmp            @loop     
          
          
@setDirFireLeft
          lda            sprx2
          sbc            #36
          sta            sprxFire2

          ldx            #ptrJPLeft
          stx            dirFire2
          
@loop
          
          ldx            dirFire2
          cpx            #ptrJPLeft
          beq            @decrementFire
          
          lda            sprxFire2  
          clc
          adc            #$02 ; cantidad de pixels que aumenta
          sta            sprxFire2
          bcs            @setStatus0
          jmp            @next     

@decrementFire
          lda            sprxFire2
          sec
          sbc            #$02 ; cantidad de pixels que decrementa
          sta            sprxFire2
          bcc            @setStatus0
          jmp            @next     

          
@setStatus0          
          ldx            #$0       ; si no seteo flag en 0
          stx            fire2
          
          lda            spractive  ; los sprites que esten activos
          and            #%11110111 ; apago el sprite 4 (disparo P2)
          sta            spractive  ; desactivamos el disparo

@next          
          rts
          
