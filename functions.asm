; copyToScreen: copia desde la direccion que especificamos en las direciones 
;             lsbCopyAddress & msbCopyAddress, hasta la direccion de pantalla $0400 
; ejemplo:
;                ldx            #<screen
;                stx            lsbCopyAddress
;                ldx            #>screen
;                stx            msbCopyAddress
;                jsr            copyToScreen


copyToScreen
; 0- 255 
          ldy            #$00
@loop
          lda            (lsbCopyAddress),y
          sta            scrPtr,y  
          
          iny
          cpy            #$00       
          bne            @loop     
          
; 256 - 512
          ldy            #$00
          inc            msbCopyAddress
@loop2
          lda            (lsbCopyAddress),y
          sta            scrPtr + $100,y
          
          iny
          cpy            #$00       
          bne            @loop2

; 513 - 768
          ldy            #$00
          inc            msbCopyAddress
@loop3
          lda            (lsbCopyAddress),y
          sta            scrPtr + $200,y
          
          iny
          cpy            #$00       
          bne            @loop3

; 768 - 1000
          ldy            #$00
          inc            msbCopyAddress
@loop4
          lda            (lsbCopyAddress),y
          sta            scrPtr + $300,y
          
          iny
          cpy            #232     
          bne            @loop4
          
          rts
              

; copyToScreenColor: copia desde la direccion que especificamos en las direciones 
;             lsbCopyAddress & msbCopyAddress, hasta la direccion de color de pantalla


copyToScreenColor
; 0- 255 
          ldy            #$00
@loop
          lda            (lsbCopyAddress),y
          sta            scrColPtr,y  
          
          iny
          cpy            #$00       
          bne            @loop     
          
; 256 - 512
          ldy            #$00
          inc            msbCopyAddress
@loop2
          lda            (lsbCopyAddress),y
          sta            scrColPtr + $100,y
          
          iny
          cpy            #$00       
          bne            @loop2

; 513 - 768
          ldy            #$00
          inc            msbCopyAddress
@loop3
          lda            (lsbCopyAddress),y
          sta            scrColPtr + $200,y
          
          iny
          cpy            #$00       
          bne            @loop3

; 768 - 1000
          ldy            #$00
          inc            msbCopyAddress
@loop4
          lda            (lsbCopyAddress),y
          sta            scrColPtr + $300,y
          
          iny
          cpy            #232     
          bne            @loop4
          
          rts
              

