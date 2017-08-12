{
          ldx            skiprt    
          cpx            #$00
          bne            next     
          ldx            #skiprtCant
          stx            skiprt    
          
loop:     ldx            raster
          cpx            #$0       
          bne            loop     
next:     
          dec            skiprt    
}
