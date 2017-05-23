detectCollision
                                   ; detecto que ocurrio una colision de sprites
          lda            $d019     
          and            #$04      
          cmp            #$04      
          bne            @jmpSkipSprDetect0
          
          lda            $d01e     
          pha                      ; lo guardo en el stack, por si lo tengo que checkear nuevamente
          
                                   ; check JP2 & fire JP1 
          ldx            statusJP2 ; solo chequeo colision si el status es 2 (normal)
          cpx            #2        
          bne            @checkJP1 
          
          and            #JP2 + FJP1
          cmp            #JP2 + FJP1
          bne            @checkJP1
          
          pla                      ; lo recupero del stack
          jsr            turnOffFire1
          inc            JP1hits   
          jsr            updateJP1hits
          ldx            #3
          stx            statusJP2
@jmpSkipSprDetect0
          jmp            @skipSprDetect

@checkJP1
                                   ; check JP1 & fire JP2
          
          pla                      ; lo recupero del stack
                                   ; notifico colision JP2 & fire JP1
          ldx            statusJP1 ; solo chequeo colision si el status es 2 (normal)
          cpx            #2        
          bne            @skipSprDetect
          
          and            #JP1 + FJP2
          cmp            #JP1 + FJP2
          bne            @jmpSkipSprDetect0
                
                                   ; notifico colision JP1 & fire JP2
          jsr            turnOffFire2
          inc            JP2hits   
          jsr            updateJP2hits

          ldx            #3
          stx            statusJP1 
          
          



@skipSprDetect
          rts
          