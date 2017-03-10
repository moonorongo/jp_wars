; constantes
gravity   = $05                    ; usado para setear la 'fuerza' de la gravedad, 1 = super fuerte, mayor = mas debil
floorPosition = 223
topPosition = 52
          
ptrJPLeft = $23
ptrJPRight = $21
ptrJPFire = $22




; direcciones memoria
raster    = $d012
cborde    = $d020
cfondo    = $d021
spractive = $d015
sprxpandX = $d01d    
scrPtr    = $0400
scrColPtr = $d800
      
          
; direcciones jetpac 
sprcolor  = $d027
sprpoint  = $07f8
sprx      = $d000
spry      = $d001
joy2      = $dc00
fire1     = $02                    ; zero page direccion sin usar
gravityCounter = $04
          
; direcciones disparo
sprcolorFire  = $d028
sprpointFire  = $07f9
sprxFire      = $d002
spryFire      = $d003
          
skiprt    = $03
          

