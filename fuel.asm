animateFuel:
{
status0:                                // esperar hasta cambiar a status 1
          ldx            statusFuel
          cpx            #0        
          bne            status1  

          lda            tick64 
          cmp            #0        
          beq            decrementFuelCounter
          jmp            exitFuel 
          
decrementFuelCounter:
          dec            fuelCounter
          beq            setStatus1
          jmp            exitFuel 
          
setStatus1:
          ldx            #1        
          stx            statusFuel

status1:
          ldx            statusFuel
          cpx            #1        
          bne            status2  
          
          ldy            #0             // inicializo pos y fuel (top pantalla)
          sty            spryfuel  

          lda            spractive      // activo sprite 4
          ora            #FUEL      
          sta            spractive 
          
                                        // posicion x fuel (random entre 48 y 303)
          lda            sprxBit8       // borro el bit8 del sprxfuel 
          and            #%11101111
          sta            sprxBit8  
          
          jsr            randomGenerator
          clc
          lda            random         // obtengo un nro del generador random
          adc            #48            // lo centro un poco
          sta            sprxfuel  
          bcs            setBit8  
          
          jmp            setStatus2  
setBit8:                           
          lda            sprxBit8  
          ora            #%00010000
          sta            sprxBit8  

setStatus2:
          ldx            #2
          stx            statusFuel

status2:                                // caida libre hasta el piso.
          ldx            statusFuel
          cpx            #2
          bne            status3  

                                        // incremento cada 4 frames
          lda            tick4
          cmp            #0        
          beq            incrementFuel_y
          jmp            exitFuel 

incrementFuel_y:
          inc            spryfuel  
          ldy            spryfuel  
          cpy            #floorPosition + 3
          beq            setStatus3
          jmp            exitFuel 
          
setStatus3:
          ldx            #3
          stx            statusFuel


status3:                                // queda en el piso esperando.                        
          ldx            statusFuel
          cpx            #3
          bne            status4  
          
          jmp            exitFuel 
          
status4:                                // reinicializa statusFuel a 0
          ldx            #0        
          stx            statusFuel
          ldx            #delayEntreFuels 
          stx            fuelCounter

          lda            spractive      // apago sprite 4
          and            #255 - FUEL       
          sta            spractive 
          

exitFuel:
          rts
}
