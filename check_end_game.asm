checkEndGame
          ldx            JP1hits   
          cpx            #10       
          beq            @JP1Wins  
          
          ldx            JP2hits   
          cpx            #10       
          beq            @JP2Wins  
          
          ldy            #0     ; devuelvo en Y que no se alcanzo los hits
          jmp            @exit     
          
@JP1Wins
          ldy            #1        ; devuelvo en Y que termino la partida
          ldx            #$05 
          stx            cborde    
          jmp            @loop     
          

          
@JP2Wins
          ldy            #1        ; devuelvo en Y que termino la partida
          ldx            #$03
          stx            cborde

@loop
          ldx            $CB       ; current key pressed, $40 no key
          cpx            #$3f      ; if run/stop
          beq            @exit
          jmp            @loop 

          

@exit
          rts
          