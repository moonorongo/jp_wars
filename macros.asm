.macro waitrt() {
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

.macro unsetB8(spriteNumber) {
          lda            sprxBit8 
          and            #255 - spriteNumber
          sta            sprxBit8
}

.macro setB8(spriteNumber) {
          lda            sprxBit8 
          ora            #spriteNumber
          sta            sprxBit8
}


.macro playNoise(freq) {
    ldx #freq
    stx sid_hfreq3
    ldx #129
    stx sid_wave3
    ldx #128
    stx sid_wave3
}
