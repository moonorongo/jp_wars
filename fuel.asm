animateFuel
@status0                ; esperar hasta cambiar a status 1
          ldx            statusFuel
          cpx            #0        
          bne            @status1  

          ldx            #0        
          stx            $0400     
          
          lda            tick4 ;tick64
          cmp            #0        
          bne            @decrementFuelCounter
          jmp            @exitFuel 
          
@decrementFuelCounter          
          dec            fuelCounter
          beq            @setStatus1
          jmp            @exitFuel 
          
@setStatus1
          ldx            #1        
          stx            statusFuel

@status1                ; elije un numero entre 50 y bit8 + 40
          ldx            statusFuel
          cpx            #1        
          bne            @status2  
          
          ldx            #1
          stx            $0401

          ldy            #80        ; inicializo pos y fuel (top pantalla)
          sty            spryfuel  

          lda            spractive ; activo sprite 4
          ora            #16       
          

          clc                      ; seteo bit8 segun si un nro aleatorio es > 80
          lda            random    
          cmp            #$80      
          bcs            @setBit8  
          
          lda            sprxBit8  ; posiciono (bit8 0) en la pantalla, entre 50 y 255
          and            #255-16 
          
          sec                      
          lda            random    
          cmp            #50       
          bcc            @setX50fuel
      
          sta            sprxfuel  
          
          ldx            #2        
          stx            statusFuel
          
          jmp            @status2  
    
@setX50Fuel                         ; si el num es > 50, entonces es 50
          lda            #50       
          sta            sprxfuel  
          
          ldx            #2        
          stx            statusFuel

          jmp            @status2  

@setBit8                           ; posiciono (bit8 1) entre 255 y 295
          lda            sprxBit8  
          ora            #%00010000
          
          clc
          lda            random    
          cmp            #40       
          bcs            @setX40fuel
          
          sta            sprxfuel  
          
          ldx            #2        
          stx            statusFuel

          jmp            @status2  
          
@setX40Fuel                       ; si la posicion me da > 295 (fuera de pantalla), reposiciono en 295
          lda            #40       
          sta            sprxfuel  
          
          ldx            #2        
          stx            statusFuel
          
          jmp            @status2  

@status2                ; caida libre hasta el piso.
          ldx            statusFuel
          cpx            #2
          bne            @status3  

          ldx            sprxfuel
          stx            $0402

;          inc            spryfuel  
;          ldy            spryfuel  
;          cpy            #floorPosition
;          beq            @setStatus3
          jmp            @exitFuel 
          
;@setStatus3          
;          ldx            #3
;          stx            statusFuel
;          jmp            @status3
          
; no activa el sprite, o lo esta mostrando en cualquier parte de la pantalla... ver

; aca o en otro lado hay que detectar si colisiona con CUALQUIER sprite
; si colisiona con p1, entonces incrementa combustible p1
; colisiona con p2, inc fuel p2
; colisiona con cualquier disparo, se destruye

; de momento llega al piso y se destruye          


@status3                ; queda en el piso esperando.                        
          ldx            statusFuel
          cpx            #3
          bne            @status4  
          
          ldx            #3
          stx            $0403



@status4                ;reinicializa statusFuel a 0
          ldx            #0        
          stx            statusFuel
          ldx            #delayEntreFuels 
          stx            fuelCounter

          ldx            #4
          stx            $0404
          
          lda            spractive ; apago sprite 4
          and            #255 - 16       
          

@exitFuel
          rts
          