{                                           // detecto que ocurrio una colision de sprites
          lda            $d019     
          and            #$04      
          cmp            #$04      
          bne            jmpSkipSprDetect0
          
          lda            $d01e
          sta            tempCollision      // lo guardo en el temporal, por si lo reviso despues
          
                                            // check JP2 & fire JP1 
          ldx            statusJP2          // solo chequeo colision si el status es 2 (normal)
          cpx            #2        
          bne            checkJP1 

          ldx            JP2Inmunidad       // chequeo que no este con la inmunidad de entrada
          cpx            #0        
          bne            checkJP1
          
          and            #JP2 + FJP1
          cmp            #JP2 + FJP1
          bne            checkJP1
          
          jsr            turnOffFire1
          inc            JP1hits   
          jsr            updateJP1hits
          ldx            #3
          stx            statusJP2 
          
          jmp            checkJP1 

jmpSkipSprDetect0:
          jmp            skipSprDetect

checkJP1:
                                            // check JP1 & fire JP2
          lda            tempCollision      // lo recupero del temporal
                                            // notifico colision JP2 & fire JP1
          ldx            statusJP1          // solo chequeo colision si el status es 2 (normal)
          cpx            #2        
          bne            checkJP1Fuel

          ldx            JP1Inmunidad       // chequeo que no este con la inmunidad de entrada
          cpx            #0        
          bne            checkJP1Fuel

          and            #JP1 + FJP2
          cmp            #JP1 + FJP2
          bne            checkJP1Fuel
                
                                            // notifico colision JP1 & fire JP2
          jsr            turnOffFire2
          inc            JP2hits   
          jsr            updateJP2hits

          ldx            #3
          stx            statusJP1 
          

checkJP1Fuel:                               // detecta si JP1 agarro fuel
          lda            tempCollision      // lo recupero del temporal
          and            #JP1 + FUEL
          cmp            #JP1 + FUEL
          bne            checkJP2Fuel
          
          ldx            #4
          stx            statusFuel
          
                                            // y le sumo combustible
          clc
          lda            JP1Jet    
          adc            #cantFUEL 
          sta            JP1Jet    
          bcs            setMaxFuel1
          jmp            checkJP2Fuel
setMaxFuel1:
          lda            #$ff      
          sta            JP1Jet    

checkJP2Fuel:                               // detecta si JP2 agarro fuel
          lda            tempCollision      // lo recupero del temporal
          and            #JP2 + FUEL
          cmp            #JP2 + FUEL
          bne            checkFireFuel1
          
          ldx            #4
          stx            statusFuel

          clc
          lda            JP2Jet    
          adc            #cantFUEL 
          sta            JP2Jet    
          bcs            setMaxFuel2
          jmp            checkFireFuel1
setMaxFuel2:
          lda            #$ff      
          sta            JP2Jet    


checkFireFuel1:                             // detecta si se destruyo con tiros 
          lda            tempCollision      // lo recupero del temporal
          and            #FUEL + FJP1
          cmp            #FUEL + FJP1
          bne            checkFireFuel2
          
          jsr            turnOffFire1
          ldx            #4
          stx            statusFuel

checkFireFuel2:                             // detecta si se destruyo con tiros 
          lda            tempCollision      // lo recupero del temporal
          and            #FUEL + FJP2
          cmp            #FUEL + FJP2
          bne            skipSprDetect
          
          jsr            turnOffFire2
          ldx            #4
          stx            statusFuel

skipSprDetect:
}
