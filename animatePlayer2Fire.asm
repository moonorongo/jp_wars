{
          ldx            fire2     
          cpx            #$0       
          bne            initFire
          jmp            next      // vuelve si status fire es 0
          
initFire:
          ldx            fire2     
          cpx            #$1       
          bne            loop     
                                   // init fire (status 1)          
          ldx            spry2
          stx            spryFire2  

          inc            fire2     // paso a status 2 (disparando)
        
          ldx            sprpoint2  
          cpx            #ptrJPLeft
          beq            setDirFireLeft
           
          ldx            #ptrJPRight
          stx            dirFire2   

          lda            sprxBit8  
          and            #4                
          cmp            #4        
          bne            jp2Bit8Off

          jsr            invertBit8_2
          
jp2Bit8Off:
          clc
          lda            sprx2
          adc            #12       
          sta            sprxFire2
          bcs            setB8    
          jmp            loop     
          
setB8:    jsr            invertBit8_2
          jmp            loop     

// movimiento disparo hacia la izquierda          
setDirFireLeft:
          ldx            #ptrJPLeft
          stx            dirFire2   

          lda            sprxBit8  
          and            #4        
          cmp            #4              // VER SI ESTA OK
          bne            jp2Bit8Off_2
          
          lda            sprxBit8
          ora            #%00001000
          sta            sprxBit8  

jp2Bit8Off_2:          
          sec
          lda            sprx2      
          sbc            #36
          sta            sprxFire2  
          bcc            unsetB8
          
          jmp            loop     
          
unsetB8:  jsr            invertBit8_2

loop:
          ldx            dirFire2   
          cpx            #ptrJPLeft       
          beq            decrementFire
          
          lda            sprxBit8  
          and            #8        
          cmp            #8
          beq            bit8On   // si el bit8 esta prendido voy a checkear si llego al borde
          
          // Bit 8 apagado
          clc
          lda            sprxFire2 
          adc            #$02      // cantidad de pixels que aumenta
          sta            sprxFire2 
          bcs            setB8_2 
          jmp            next    
          
setB8_2:  jsr            invertBit8_2
          jmp            next     
          
bit8On:
          clc
          lda            sprxFire2  
          adc            #2            // cantidad de pixels que aumenta
          sta            sprxFire2  
          cmp            #90           // borde de la pantalla
          bcs            setStatus0
          jmp            next     

decrementFire:
          lda            sprxBit8  
          and            #8
          cmp            #8
          beq            bit8On_2      // si el bit8 esta prendido voy a checkear si llego a 0 
          
          // Bit 8 apagado
          sec
          lda            sprxFire2
          sbc            #$02
          sta            sprxFire2
          bcc            setStatus0
          jmp            next    

bit8On_2:
          sec
          lda            sprxFire2
          sbc            #$02           // cantidad de pixels que decrementa
          sta            sprxFire2
          bcc            setB8_2 
          jmp            next     
          
setStatus0:          
          jsr            turnOffFire2
          
next:
}          

