tickGenerator          
          lda            internalCounter 
          and            #4
          sta            tick4         ; guardo tick8 anterior
          
          inc            internalCounter
          
          lda            internalCounter
          and            #4         
          cmp            tick4         ; comparo con nuevo tick4
          
          bne            @setTick4_1   
          
          ldx            #0
          stx            tick4

          jmp            @skip     

@setTick4_1
          ldx            #1  
          stx            tick4 

@skip
          rts
          
          

