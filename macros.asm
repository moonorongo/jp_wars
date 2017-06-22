defm      waitrt
          ldx            skiprt    
          cpx            #$00
          bne            @next     
          ldx            #skiprtCant
          stx            skiprt    
          
@loop     ldx            raster
          cpx            #$0       
          bne            @loop     
@next     
          dec            skiprt    
          endm


defm      unsetB8
          lda            sprxBit8 
          and            #255 - /1
          sta            sprxBit8
          endm


defm      setB8
          lda            sprxBit8 
          ora            #/1
          sta            sprxBit8
          endm

