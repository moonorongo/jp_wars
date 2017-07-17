{                                   // -------------- STATUS 0 -------
          ldx            statusJP2 
          cpx            #0
          bne            statusJP2_1
                                   // INIT SPRITE JP2
          setB8(JP2)
          
          ldx            #40      // posicionamos jetpac 2
          stx            sprx2
          ldx            #0        // que salga desde arriba de la pantalla...
          stx            spry2     
          lda            #ptrJPLeft      
          sta            sprpoint2 // jet pac 2 mirando a la izquierda
          
          lda            #JP2Color
          sta            sprcolor2  // jetpac 2 color cyan
          
          lda            #TiempoInmune
          sta            JP2Inmunidad
                        
          ldx            #1        
          stx            statusJP2 
          
statusJP2_1:                       // -------------- STATUS 1 -----------------
                                   
          ldx            statusJP2 
          cpx            #1        
          bne            statusJP2_2
          
          inc            spry2      
          ldy            spry2      
          cpy            #50       
          beq            set_statusJP2_2
          
          jmp            exit     
          
set_statusJP2_2:
          ldx            #2
          stx            statusJP2
          
          
statusJP2_2:                       // -------------- STATUS 2 -----------------------
          ldx            statusJP2
          cpx            #2        
          beq            chkUp
      
          jmp            statusJP2_3
          
jmpNext:  jmp            next
chkUp:
          lda            JP2Inmunidad
          cmp            #0        
          beq            doNotDecrement
          
          dec            JP2Inmunidad
          and            #8
          beq            setBlackColor
          
          ldx            #JP2Color 
          stx            sprcolor2
          jmp            skipRestoreColor
          
setBlackColor:
          ldx            #JPBlackColor
          stx            sprcolor2
          jmp            skipRestoreColor
          
doNotDecrement:
          lda            sprcolor2  
          and            #15       
          cmp            #JPBlackColor
          bne            skipRestoreColor
          lda            #JP2Color 
          sta            sprcolor2
          
skipRestoreColor:
          lda            joy1      
          cmp            #127      
          beq            jmpNext  // avoid +- 127 bytes jmp long

          ldx            JP2Jet    // check si hay fuel 
          cpx            #$0       
          beq            chkLeft  // si no hay pasa de largo... adiooos
          
          lda            joy1      
          and            #1        // up
          bne            chkLeft
          jsr            checkTopP2 // solo sube si no llego al tope
          cpx            #1        
          beq            chkLeft
          
          dec            spry2     
          
          lda            tick64 
          cmp            #0
          bne            chkLeft  // cada 64 frames gasta combustible
          dec            JP2Jet    // gasta combustible


chkLeft:  lda            joy1      
          and            #4        // left
          bne            chkRight  
          
          jsr            checkFloorP2 // solo se mueve si esta volando
          cpx            #1      
          beq            chkRight  

          lda            #ptrJPLeft      
          sta            sprpoint2  
          
          sec
          lda            sprx2
          sbc            #1        
          bcc            chkOvrL               // si ocurre acarreo, llamo a checkOverflowP1
          sta            sprx2                   // si no, estamos en la de antes, actualizo posivion
          jmp            chkRight 
          
chkOvrL:  jsr            checkOverflowP2
          sta            sprx2                   // actualizo posicion, con el bit 8 actualizado

chkRight: lda            joy1      
          and            #8        // right
          bne            chkFire   
          
          jsr            checkFloorP2 // solo se mueve si esta volando
          cpx            #1      
          beq            chkFire  

          lda            #ptrJPRight      
          sta            sprpoint2  

          clc
          lda            sprx2
          adc            #1        
          bcs            chkOvrR               // si ocurre acarreo, llamo a checkOverflowP1
          sta            sprx2                   // si no, estamos en la de antes, actualizo posicion
          jmp            chkFire 
          
chkOvrR:  jsr            checkOverflowP2
          sta            sprx2                   // actualizo posicion, con el bit 8 actualizado

chkFire:  lda            joy1      
          and            #16       // fire
          bne            next
          
          ldx            fire2     
          cpx            #0        
          bne            next      // checkeo si ya disparo
          
          lda            #1        // setea status fire1 
          sta            fire2     
          
          lda            spractive  // los sprites que esten activos
          ora            #%00001000 // activo sprite 4 (disparo P2)
          sta            spractive  //activamos el disparo
          
//         end check joystick          
          

next:
          ldx            gravityCounter2
          dex
          stx            gravityCounter2
          cpx            #$0       
          bne            exit
          
          jsr            checkFloorP2
          cpx            #1      
          beq            skipGravity
          
         
          inc            spry2      // gravity :P 

skipGravity:
          ldx            #gravity
          stx            gravityCounter2
          
          jmp            exit     
          
          
statusJP2_3:                       // --------------- STATUS 3 -----------------
             
          ldx            gravityCounter2
          dex
          stx            gravityCounter2
          cpx            #$0       
          bne            exit
          ldx            #gravity
          stx            gravityCounter2


          lda            tick4
          cmp            #0
          bne            skipIncFallCounter // cada 4 frames va  a incrementar fallCounter

          lda #0
          inc            fallCounter2
          
skipIncFallCounter:
          lda            spry2
          adc            fallCounter2
          sta            spry2
          
          ldx            fallCounter2 
          dex                           // uso fallCounter como contador de frames (pero necesito que sea -1)
          cpx            #4             // hasta que llegue a 4 (animacion de 5 frames, no mas)
          beq            explodeEnded  // si es igual, que no asigne ningun puntero mas...
          
          txa
          adc            #ptrJPExplode
          sta            sprpoint2
          
explodeEnded:
          ldx            sprpoint
          cpx            #ptrJPRight  // si esta mirando a la derecha
          bne            chkFloor  
         
chkFloor:
          jsr            checkFloorP2
          cpx            #1        
          bne            exit
          
          ldx            #0             
          stx            fallCounter2

          ldx            #0        // si llego al piso cambia a status 0
          stx            statusJP2
          

exit:
          jsr            checkBordersJP2
          jsr            updateJP2Jet
}          
// ------------- end of main animatePlayer2 ---------------------------                
