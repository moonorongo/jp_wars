

checkBordersJP2:
{
          lda            sprxBit8  
          and            #4
          cmp            #4        
          beq            bit8On

          ldx            sprx2
          cpx            #0
          bne            return   
          
          setB8(4)         // setea bit 8 de sprite 3
          ldx            #89
          stx            sprx2
          jmp            return   
          
bit8On:
          ldx            sprx2
          cpx            #90
          bne            return   
          
          unsetB8(4)
          ldx            #1
          stx            sprx2 
          
return:
          rts
}


// verifica posicion X, setea bit 8 spr 0
checkOverflowP2:
{
          tax                           // guardo A en X (lo necesito despues)
          lda            sprxBit8       
          eor            #4             // invierto el bit8 de posicion (sprite 2)
          sta            sprxBit8       
          txa                           // restauro A
          rts
}


// verifica posicion Y de P2, y retorna 1 en X si es el piso 
checkFloorP2:
{
          clc
          ldx            spry2
          cpx            #floorPosition
          beq            returnTrue    // is equal
          bcs            returnTrue    // or greater //) 
          ldx            #0        
          rts
returnTrue:
          ldx            #1        
          rts
}         


// verifica posicion Y de P2, y retorna 1 en X si es el top
checkTopP2:
{
          ldx            spry2
          cpx            #topPosition
          beq            returnTrue    // is equal
          //bcs            returnTrue    // or greater 
          ldx            #0        
          rts
returnTrue:
          ldx            #1        
          rts
}          


// muestra los hits del jetpac 2
updateJP2hits:
{
          lda            JP2hits   
          jsr            convert2ascii
          sty            $07E0
          stx            $07E1
          sta            $07E2
          rts
}


// actualiza el medidor de JET de JP2
updateJP2Jet:
{
          lda            JP2Jet   
          jsr            convert2ascii
          sty            $07E5
          stx            $07E6
          sta            $07E7
          rts
}





// invert Bit 8 de disparo JP2
invertBit8_2:
{
          lda            sprxBit8       
          eor            #8             
          sta            sprxBit8       
          rts
}



// turn off fire player 2
turnOffFire2:
{
          ldx            #$0          // si no seteo flag en 0
          stx            fire2
          
          lda            spractive    // los sprites que esten activos
          and            #255 - FJP2  // apago disparo P1
          sta            spractive    // desactivamos el disparo
          
          lda            sprxBit8     // apago bit 8      
          and            #%11110111 
          sta            sprxBit8       

          rts
}
