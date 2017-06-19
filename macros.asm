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



;defm      copyScreen
;          ldx            #$00      
;@loop          
;          lda            screen,x  
;          sta            scrPtr,x  
;
;          lda            screen + $100,x  
;          sta            scrPtr + $100,x  

;          lda            screen + $200,x  
;          sta            scrPtr + $200,x  

;          lda            screen + $300,x  
;          sta            scrPtr + $300,x  
          
;          lda            colour,x  
;          sta            scrColPtr,x

;          lda            colour + $100,x  
;          sta            scrColPtr + $100,x
          
;          lda            colour + $200,x  
;          sta            scrColPtr + $200,x
          
;          lda            colour + $300,x  
;          sta            scrColPtr + $300,x
          
;          inx
;          cpx            #$00       
;          bne            @loop     
;          endm
          



