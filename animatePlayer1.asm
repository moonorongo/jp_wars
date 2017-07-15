{
                                       // -------------- STATUS 0 -------
          ldx            statusJP1 
          cpx            #0
          bne            statusJP1_1
                                       // INIT SPRITE JP1
          
          unsetB8(JP1)
          
          ldx            #50           // posicionamos jetpac 1
          stx            sprx
          ldx            #0            // que salga desde arriba de la pantalla...
          stx            spry      
          lda            #ptrJPRight      
          sta            sprpoint      // jet pac 1 mirando a la derecha
                        
          lda            #JP1Color
          sta            sprcolor      // jetpac 1 color verde
          
          lda            #TiempoInmune
          sta            JP1Inmunidad
          
          ldx            #1        
          stx            statusJP1 
          
statusJP1_1:                           // -------------- STATUS 1 -----------------
                                   
          ldx            statusJP1 
          cpx            #1        
          bne            statusJP1_2
          
          inc            spry      
          ldy            spry      
          cpy            #50       
          beq            set_statusJP1_2
          
          jmp            exit     
          
set_statusJP1_2:
          ldx            #2
          stx            statusJP1 
          
          
statusJP1_2:                           // -------------- STATUS 2 ----------------------------
          ldx            statusJP1 
          cpx            #2        
          beq            chkUp
      
          jmp            statusJP_3
          
jmpNext:  jmp            next
chkUp:
          lda            JP1Inmunidad
          cmp            #0        
          beq            doNotDecrement
          
          dec            JP1Inmunidad
          and            #8
          beq            setBlackColor
          
          ldx            #JP1Color 
          stx            sprcolor  
          jmp            skipRestoreColor
          
setBlackColor:
          ldx            #JPBlackColor
          stx            sprcolor
          jmp            skipRestoreColor
          
doNotDecrement:
          lda            sprcolor  
          and            #15       
          cmp            #JPBlackColor
          bne            skipRestoreColor
          lda            #JP1Color 
          sta            sprcolor  
          
skipRestoreColor:
          lda            joy2      
          cmp            #127      
          beq            jmpNext      // avoid +- 127 bytes jmp long

          ldx            JP1Jet        // check si hay fuel 
          cpx            #$0       
          beq            chkLeft      // si no hay pasa de largo... adiooos

          lda            joy2      
          and            #1            // up
          bne            chkLeft
          jsr            checkTopP1    // solo sube si no llego al tope
          cpx            #1        
          beq            chkLeft
          
          dec            spry
          
          lda            tick64
          cmp            #0
          bne            chkLeft      // cada 64 frames gasta combustible
          dec            JP1Jet        // gasta combustible

chkLeft:  lda            joy2      
          and            #4            // left
          bne            chkRight 
          
          jsr            checkFloorP1  // solo se mueve si esta volando
          cpx            #1      
          beq            chkRight  

          lda            #ptrJPLeft    // pone sprite mirando a la izquierda
          sta            sprpoint  

          sec
          lda            sprx      
          sbc            #1        
          bcc            chkOvrL      // si ocurre acarreo, llamo a checkOverflowP1
          sta            sprx          // si no, estamos en la de antes, actualizo posivion
          jmp            chkRight 
          
chkOvrL:  jsr            checkOverflowP1
          sta            sprx          // actualizo posicion, con el bit 8 actualizado

chkRight: lda            joy2      
          and            #8            // right
          bne            chkFire   
          
          jsr            checkFloorP1  // solo se mueve si esta volando
          cpx            #1      
          beq            chkFire  

          lda            #ptrJPRight      
          sta            sprpoint      // pone sprite mirando a la derecha
          
          clc
          lda            sprx                   
          adc            #1        
          bcs            chkOvrR      // si ocurre acarreo, llamo a checkOverflowP1
          sta            sprx          // si no, estamos en la de antes, actualizo posivion
          jmp            chkFire 
          
chkOvrR:  jsr            checkOverflowP1
          sta            sprx          // actualizo posicion, con el bit 8 actualizado

chkFire:  lda            joy2      
          and            #16           // fire
          bne            next
          
          ldx            fire1     
          cpx            #0        
          bne            next         // checkeo si ya disparo
          
          lda            #1            // setea status fire1 
          sta            fire1     
          
          lda            spractive     // los sprites que esten activos
          ora            #%00000010    // activo sprite 2 (disparo P1)
          sta            spractive     // activamos el disparo
          
                                       // end check joystick          
          

next:
          ldx            gravityCounter
          dex
          stx            gravityCounter
          cpx            #$0       
          bne            exit
          
          jsr            checkFloorP1
          
          cpx            #1            // check floor (si result checkFloorP1 es 1 es el piso)
          beq            skipGravity
          
         
          inc            spry          // gravity :P 

skipGravity:
          ldx            #gravity
          stx            gravityCounter
          
          jmp            exit     
          
          
statusJP_3:                            // --------------- STATUS 3 -----------------
             
          ldx            gravityCounter
          dex
          stx            gravityCounter
          cpx            #$0       
          bne            exit
          ldx            #gravity
          stx            gravityCounter

          lda            tick4
          cmp            #0
          bne            skipIncFallCounter // cada 4 frames va  a incrementar fallCounter

          lda #0
          inc            fallCounter
          
skipIncFallCounter:
          lda            spry      
          adc            fallCounter
          sta            spry          // cae JP1 vertiginosamente (cada vez mas)
          
          ldx            fallCounter 
          dex                          // uso fallCounter como contador de frames (pero necesito que sea -1)
          cpx            #4            // hasta que llegue a 4 (animacion de 5 frames, no mas)
          beq            explodeEnded // si es igual, que no asigne ningun puntero mas...
          
          txa
          adc            #ptrJPExplode
          sta            sprpoint  
          
explodeEnded:          
          ldx            sprpoint2   
          cpx            #ptrJPRight   // si esta mirando a la derecha
          bne            chkFloor  
          
chkFloor:
          jsr            checkFloorP1
          cpx            #1        
          bne            exit
          
          ldx            #0      
          stx            fallCounter

          ldx            #0        
          stx            statusJP1 

exit:
          jsr            checkBordersJP1
          jsr            updateJP1Jet
          
}          
// ------------- end of main animatePlayer1 ---------------------------                


