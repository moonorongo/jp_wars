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

          lda            sprx      
          adc            #12
          sta            sprxFire
          inc            fire1     ; paso a status 2 (disparando)

@loop
          lda            #1        
          adc            sprxFire  ; incremento 3 x disparo
          sta            sprxFire  
          
          bcs            @setStatus0
          jmp            @next     
          
@setStatus0          
          ldx            #$0       ; si no seteo flag en 0
          stx            fire1     
          lda            #$01      
          sta            spractive ; desactivamos el sprite 1 
          
@next          
          rts
          
