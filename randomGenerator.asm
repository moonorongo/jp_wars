randomGenerator
          lda            random      
          beq            @doEor     
          asl
          beq            @noEor     ;if the input was $80, skip the EOR
          bcc            @noEor     
@doEor    eor            #$1d
@noEor    sta            random
          rts
          

          