; constantes
gravity   = $05                    ; usado para setear la 'fuerza' de la gravedad, 1 = super fuerte, mayor = mas debil
floorPosition = 223
topPosition = 52
          
ptrJPLeft = $23
ptrJPRight = $21
ptrJPFire = $22
skiprt    = $03


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
      
          
; direcciones jetpac 1 -------------------------------------------------------
sprcolor  = $d027
sprpoint  = $07f8
sprx      = $d000
spry      = $d001
fire1     = $02                    ; zero page direccion sin usar
gravityCounter = $04

          
; direcciones disparo
sprcolorFire  = $d028
sprpointFire  = $07f9
sprxFire      = $d002
spryFire  = $d003
          
; dirFire esta en la direccion de memoria que me sobra del sprite de disparo
          
          
; direcciones jetpac 2 -------------------------------------------------------
sprcolor2  = $d029
sprpoint2  = $07fa
sprx2      = $d004
spry2      = $d005
fire2     = $2a                   ; zero page direccion sin usar
gravityCounter2 = $04
          

; direcciones disparo
sprcolorFire2  = $d02a
sprpointFire2  = $07fb
sprxFire2      = $d006
spryFire2  = $d007
; dirFire2 esta en la direccion de memoria que me sobra del jet pac right

