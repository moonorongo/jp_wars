tickGenerator          
          lda            internalCounter 
          and            #4
          sta            tick4         ; guardo tick4 anterior
          
          lda            internalCounter 
          and            #64
          sta            tick64     ; guardo tick64 anterior
          
          inc            internalCounter
          
; tick4 --------------------------------------
          lda            internalCounter
          and            #4         
          cmp            tick4         ; comparo con nuevo tick4
          
          bne            @setTick4_1   
          
          ldx            #0
          stx            tick4

          jmp            @tick64

@setTick4_1
          ldx            #1  
          stx            tick4     
          
; tick64 ------------------------------------
@tick64
          lda            internalCounter
          and            #64
          cmp            tick64        ; comparo con nuevo tick64
          
          bne            @setTick64_1   
          
          ldx            #0
          stx            tick64

          jmp            @skip     

@setTick64_1
          ldx            #1  
          stx            tick64

@skip
          rts
          
          

