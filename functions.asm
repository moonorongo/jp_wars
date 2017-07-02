; copyToScreen: copia desde la direccion que especificamos en las direciones 
;             lsbCopyAddress & msbCopyAddress, hasta la direccion de pantalla $0400 
; ejemplo:
;                ldx            #<screen
;                stx            lsbCopyAddress
;                ldx            #>screen
;                stx            msbCopyAddress
;                jsr            copyToScreen

; punteros utilizados por copyScreen
; lsbCopyAddress = $0e
; msbCopyAddress = $0f           
; scrPtr    = $0400

copyToScreen
; posiciones de pantalla 0 - 255 
          ldy            #$00
@loop
          lda            (lsbCopyAddress),y
          sta            scrPtr,y  
          
          iny
          cpy            #$00       
          bne            @loop     
          
; posiciones de pantalla 256 - 512
          ldy            #$00
          inc            msbCopyAddress
@loop2
          lda            (lsbCopyAddress),y
          sta            scrPtr + $100,y
          
          iny
          cpy            #$00       
          bne            @loop2

; posiciones de pantalla 513 - 768
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
              

