checkBordersJP1:
{
          lda            sprxBit8  
          and            #1
          cmp            #1        
          beq            bit8On

          ldx            sprx
          cpx            #0
          bne            return   
          
          setB8(JP1)                // setea bit 8 de sprite 0
          ldx            #89
          stx            sprx      
          jmp            return   
          
bit8On:
          ldx            sprx
          cpx            #90
          bne            return   
          
          unsetB8(JP1)
          ldx            #1
          stx            sprx      
          
return:
          rts
}          


// verifica posicion X, setea bit 8 spr 0
checkOverflowP1:
{
          tax                          // guardo A en X (lo necesito despues)
          lda            sprxBit8       
          eor            #1            // invierto el bit8 de posicion
          sta            sprxBit8       
          txa                          // restauro A
}          
          
          


// verifica posicion Y de P1, y retorna 1 en X si es el piso 
checkFloorP1:
{
          clc
          ldx            spry      
          cpx            #floorPosition
          beq            returnTrue    // is equal
          bcs            returnTrue    // or greater 
          ldx            #0        
          rts
returnTrue:
          ldx            #1        
          rts
}


// verifica posicion Y de P1, y retorna 1 en X si es el top
checkTopP1:
{
          ldx            spry      
          cpx            #topPosition
          beq            returnTrue      // is equal
          //bcs            returnTrue    // or greater 
          ldx            #0        
          rts
returnTrue:
          ldx            #1        
          rts
}          








// muestra los hits del jetpac 1
updateJP1hits:
{
          lda            JP1hits   
          jsr            convert2ascii
          sty            $07C0
          stx            $07C1
          sta            $07C2
          rts
}          
          
// actualiza el medidor de JET de JP1
updateJP1Jet:
{
          lda            JP1Jet   
          jsr            convert2ascii
          sty            $07C5
          stx            $07C6
          sta            $07C7
          rts
}



/* funciones utilizadas por el disparo */


// invert Bit 8 de disparo JP1
invertBit8:
{
          lda            sprxBit8       
          eor            #2             
          sta            sprxBit8       
          rts
}

// turn off fire player 1
turnOffFire1:
{
          ldx            #$0          // si no seteo flag en 0
          stx            fire1     
          
          lda            spractive    // los sprites que esten activos
          and            #255 - FJP1  // apago disparo P1
          sta            spractive    // desactivamos el disparo
          
          lda            sprxBit8     // apago bit 8      
          and            #%11111101 
          sta            sprxBit8       

          rts
}          
