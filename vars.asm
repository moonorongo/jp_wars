.const gravity   = $03        // usado para setear la 'fuerza' de la gravedad, 1 = super fuerte, mayor = mas debil
.const floorPosition = 219
.const topPosition = 52
          
.const ptrJPLeft = $23
.const ptrJPRight = $21
.const ptrJPFire = $22
.const ptrJPExplode = $24     // comienzo del vector de animacion de explosion
.const ptrFuel = $29          
          
.const skiprt    = $03        // MEM POINTER  SKIPRT COUNTER
.const skiprtCant = $02       // setea contador skiprt: menor valor = mas lento// mayor valor mas rapido          
.const internalCounter = $09  // contador interno que voy a ir incrementando, de uso general.
.const tick4 = $0A            // tick generado cada 4 frames
.const tick64    = $0B        // tick generado cada 64 frames
.const random = $10           // numero 'aleatorio' generado
.const tempCollision = $12    // guardo el estado de colision $d01e
.const JPBlackColor = $2
.const TiempoInmune = $fa     // 200 refrescos de inmunidad
          

// punteros utilizados por copyScreen
.const lsbCopyAddress = $0e
.const msbCopyAddress = $0f           



// direcciones memoria
.const raster    = $d012
.const cborde    = $d020
.const cfondo    = $d021
.const spractive = $d015
.const sprxpandX = $d01d    
.const scrPtr    = $0400
.const scrColPtr = $d800
.const joy2      = $dc00
.const joy1      = $dc01
.const sprxBit8  = $d010

// registros del sid
.const sidPtr    = 54272
.const sid_vol = 54296
.const sid_hfreq1 = 54273
.const sid_ad1 = 54277
.const sid_sr1 = 54278
.const sid_wave1 = 54276

.const sid_hfreq2 = 54280
.const sid_ad2 = 54284
.const sid_sr2 = 54285
.const sid_wave2 = 54283

.const sound_fire1_freq = $c200
.const sound_fire2_freq = $c201

.const sid_hfreq3 = 54287
.const sid_ad3 = 54291
.const sid_sr3 = 54292
.const sid_wave3 = 54290

          
// direcciones jetpac 1, sprite 0 
.const sprcolor  = $d027
.const sprpoint  = $07f8
.const sprx      = $d000
.const spry      = $d001
.const fire1     = $02           // zero page direccion sin usar
.const gravityCounter = $04
.const JP1       = $01
.const JP1hits   = $c000
.const statusJP1 = $c001         // statusJP1 se utiliza en la maquina de estados de JP1
.const fallCounter = $c002       // utilizado para incrementar la caida, cuando statusJP1 == 3          
.const JP1Jet    = $c003         // cantidad de combustible del jet 1
.const JP1Color  = $05           // color verde
.const JP1Inmunidad = $C004      // tiempo de impunidad JP1      
          

          
// direcciones disparo, sprite 1
.const sprcolorFire  = $d028
.const sprpointFire  = $07f9
.const sprxFire      = $d002
.const spryFire  = $d003
.const FJP1 = $02          
// dirFire esta en la direccion de memoria que me sobra del sprite de disparo
          
          
// direcciones jetpac 2, sprite 2 -------------------------------------------------------
.const sprcolor2  = $d029
.const sprpoint2  = $07fa
.const sprx2      = $d004
.const spry2      = $d005
.const fire2     = $2a           // zero page direccion sin usar
.const gravityCounter2 = $04
.const JP2 = $04          
.const JP2hits = $c100
.const statusJP2 = $c101       
.const fallCounter2 = $c102      // utilizado para incrementar la caida, cuando statusJP2 == 3          
.const JP2Jet = $c103            // cantidad de combustible del jet 2
.const JP2Color  = $03           // jetpac 2 color cyan
.const JP2Inmunidad = $C104      // tiempo de impunidad JP2

// direcciones disparo, sprite 3
.const sprcolorFire2  = $d02a
.const sprpointFire2  = $07fb
.const sprxFire2      = $d006
.const spryFire2  = $d007
.const FJP2 = $08
// dirFire2 esta en la direccion de memoria que me sobra del jet pac right


// direcciones de fuel, sprite 4
.const sprcolorfuel = $d02b
.const sprpointfuel = $07fc
.const sprxfuel = $d008          
.const spryfuel = $d009
.const FUEL      = $10           // 16, constante sprite 
.const cantFUEL  = 10            // cantidad de combustible de cada fuel 
.const statusFuel = $c0a0
.const fuelCounter = $c0a1
.const delayEntreFuels = 32      //$ff cuanto tiempo transcurre hasta que aparezca otro fuel


