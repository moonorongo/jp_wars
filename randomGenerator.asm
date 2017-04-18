randomGenerator
          lda            seed      
          beq            @doEor     
          asl
          beq            @noEor     ;if the input was $80, skip the EOR
          bcc            @noEor     
@doEor    eor            #$1d
@noEor    sta            seed
          rts
          

          