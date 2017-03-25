convert2ascii
          ldy            #$2f      
          ldx            #$3a      
          sec
@l100     iny
          sbc            #100      
          bcs            @l100     
          
@l10      dex
          adc            #10       
          bmi            @l10      
          
          adc            #$2f      
          rts
          