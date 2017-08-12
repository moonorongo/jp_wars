initVars:
          cld                      // clear decimal flag.
          
          lda            #$00      // borde y fondo negro
          sta            cborde     
          sta            cfondo


          lda            #skiprtCant      // inicializo skiprt (conteo hasta hacer un wait retrace)
          sta            skiprt
          
          ldx            #0        // contador hits jetpac 1 y 2
          stx            JP1hits   
          stx            JP2hits   
          
          ldx            #0        
          stx            statusJP1 
          stx            statusJP2

          ldx            #0        // utilizado en animacion de JP1 cuando muere
          stx            fallCounter
          stx            fallCounter2
          
          lda            #$05      
          sta            spractive //activamos el sprite 0 y 2
          
          
          lda            #JP2Color
          sta            sprcolor2  // jetpac 2 color cyan

          lda            #TiempoInmune
          sta            JP2Inmunidad


          lda            #$02
          sta            sprcolorfuel  // color combustible


          lda            #$02
          sta            sprcolorFire  // fire color red
          sta            sprcolorFire2  // fire color red

          lda            #$0a      
          sta            sprxpandX // expandimos X el disparo 1 y 2.

          lda            #ptrJPLeft
          sta            sprpoint2  // jet pac 1 mirando a la izquierda
          
          lda            #ptrJPFire      
          sta            sprpointFire  
          sta            sprpointFire2  // punteros de disparo
          
          lda            #ptrFuel  
          sta            sprpointfuel

          lda            #$0       // fire flag 
          sta            fire1     
          sta            fire2     
          
          lda            #gravity
          sta            gravityCounter
          sta            gravityCounter2
          
          jsr            updateJP1hits
          jsr            updateJP2hits
          
          
          ldx            #0        
          stx            internalCounter
          
          ldx            #4
          stx            tick4     
          
          ldx            #64
          stx            tick64

          ldx            #$80       
          stx            JP1Jet    
          stx            JP2Jet    
          

          ldx            $a2         // inicializamos el generador de numeros aleatorios
          stx            random      // con un valor de la variable TI (que esta en $a2)
          
          ldx            #0        
          stx            statusFuel
          
          ldx            #delayEntreFuels
          stx            fuelCounter

{         
          // reseteamos los registros del SID 
          ldy #0
          lda #0
          sty sound_fire1_freq  // seteo en 0 la freq de disparo
          sty sound_fire2_freq  
loop:
          sta sidPtr,y
          iny 
          cpy #25
          bne loop

          // configuramos canal 1
          ldx #16+15            // volumen maximo 
          stx sid_vol           // filtro seteado como pasa bajo
          ldx #0
          stx sid_ad1
          ldx #100
          stx sid_hfreq1
          ldx #15*16+5          // volumen de sostenimiento max
          stx sid_sr1           // poca relajacion
          
          // configuramos canal 2
          ldx #0
          stx sid_ad2
          ldx #100
          stx sid_hfreq2
          ldx #15*16+0          // volumen de sostenimiento MENOS
          stx sid_sr2           
          
          ldx #0*16+2          // filtro voz 2, sin resonancia
          stx 54295
          
          ldx #40
          stx 54294            // frecuencia resonancia en 40
          
          // configuramos canal 3
          ldx #0
          stx sid_ad3
          ldx #3
          stx sid_hfreq3
          ldx #15*16+9          // volumen de sostenimiento max
          stx sid_sr3           // tiempo de relajacion medio          
}
          
          rts
