detectCollision
        ; detecto que ocurrio una colision de sprites
          lda            $d019     
          and            #$04      
          cmp            #$04      
          bne            @skipSprDetect
          
        ; check JP2 & fire JP1 
          lda            $d01e     
          pha                      ; lo guardo en el stack, por si lo tengo que checkear nuevamente
          and            #JP2 + FJP1
          cmp            #JP2 + FJP1
          bne            @checkJP1
          
        ; notifico colision JP2 & fire JP1
          pla                      ; lo recupero del stack
          jsr            turnOffFire1
          inc            JP1hits   
          jsr            updateJP1hits
          
          jmp            @skipSprDetect

@checkJP1
        ; check JP1 & fire JP2
          pla                      ; lo recupero del stack
          and            #JP1 + FJP2
          cmp            #JP1 + FJP2
          bne            @skipSprDetect
                
        ; notifico colision JP1 & fire JP2
          ldx            #02       
          stx            $d020     


@skipSprDetect
          rts
          