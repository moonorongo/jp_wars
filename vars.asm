gravity   = $03                   ; usado para setear la 'fuerza' de la gravedad, 1 = super fuerte, mayor = mas debil
floorPosition = 219
topPosition = 52
          
ptrJPLeft = $23
ptrJPRight = $21
ptrJPFire = $22
ptrJPExplode = $24                    ;                ; comienzo del vector de animacion de explosion
ptrFuel = $29          
          
skiprt    = $03                    ; MEM POINTER  SKIPRT COUNTER
skiprtCant = $02                   ; setea contador skiprt: menor valor = mas lento; mayor valor mas rapido          
internalCounter = $09              ; contador interno que voy a ir incrementando, de uso general.
tick4 = $0A                        ; tick generado cada 4 frames
tick64    = $0B                    ; tick generado cada 64 frames
random = $10                         ; numero 'aleatorio' generado
tempCollision = $12                    ; guardo el estado de colision $d01e
JPBlackColor = $2
TiempoInmune = $ff   ; 255 refrescos de inmunidad
          

; punteros utilizados por copyScreen
lsbCopyAddress = $0e
msbCopyAddress = $0f           



; direcciones memoria
raster    = $d012
cborde    = $d020
cfondo    = $d021
spractive = $d015
sprxpandX = $d01d    
scrPtr    = $0400
scrColPtr = $d800
joy2      = $dc00
joy1      = $dc01
sprxBit8  = $d010
      
          
; direcciones jetpac 1, sprite 0 -------------------------------------------------------
sprcolor  = $d027
sprpoint  = $07f8
sprx      = $d000
spry      = $d001
fire1     = $02                    ; zero page direccion sin usar
gravityCounter = $04
JP1       = $01
JP1hits   = $c000
statusJP1 = $c001       ; statusJP1 se utiliza en la maquina de estados de JP1
fallCounter = $c002     ; utilizado para incrementar la caida, cuando statusJP1 == 3          
JP1Jet    = $c003                  ; cantidad de combustible del jet 1
JP1Color  = $05                    ; color verde
JP1Inmunidad = $C004                  ; tiempo de impunidad JP1      
          

          
; direcciones disparo, sprite 1
sprcolorFire  = $d028
sprpointFire  = $07f9
sprxFire      = $d002
spryFire  = $d003
FJP1 = $02          
; dirFire esta en la direccion de memoria que me sobra del sprite de disparo
          
          
; direcciones jetpac 2, sprite 2 -------------------------------------------------------
sprcolor2  = $d029
sprpoint2  = $07fa
sprx2      = $d004
spry2      = $d005
fire2     = $2a                   ; zero page direccion sin usar
gravityCounter2 = $04
JP2 = $04          
JP2hits = $c100
statusJP2 = $c101       
fallCounter2 = $c102     ; utilizado para incrementar la caida, cuando statusJP2 == 3          
JP2Jet = $c103           ; cantidad de combustible del jet 2
JP2Color  = $03          ; jetpac 2 color cyan
JP2Inmunidad = $C104                  ; tiempo de impunidad JP2

; direcciones disparo, sprite 3
sprcolorFire2  = $d02a
sprpointFire2  = $07fb
sprxFire2      = $d006
spryFire2  = $d007
FJP2 = $08
; dirFire2 esta en la direccion de memoria que me sobra del jet pac right


; direcciones de fuel, sprite 4
sprcolorfuel = $d02b
sprpointfuel = $07fc
sprxfuel = $d008          
spryfuel = $d009
FUEL      = $10                    ; 16, constante sprite 
cantFUEL  = 10                    ; cantidad de combustible de cada fuel 
statusFuel = $c0a0
fuelCounter = $c0a1
delayEntreFuels = 32    ;$ff cuanto tiempo transcurre hasta que aparezca otro fuel
          











