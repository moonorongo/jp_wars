animatePlayer1
          lda            joy2      
          cmp            #127      
          beq            next      

          lda            joy2      
          and            #1        ; up
          bne            chkDown   
          dec            spry      

chkDown   lda            joy2      
          and            #2        ; down
          bne            chkLeft   
          inc            spry      
  
chkLeft   lda            joy2      
          and            #4        ; left
          bne            chkRight  
          dec            sprx      
          
chkRight  lda            joy2      
          and            #8        ; right
          bne            chkFire   
          inc            sprx      

chkFire   lda            joy2      
          and            #16       ; fire
          bne            next      
          
          ldx            fire1     
          cpx            #0        
          bne            next      ; checkeo si ya disparo
          
          lda            #1        ; setea status fire1 
          sta            fire1     
          lda            #$03      
          sta            spractive ;activamos el sprite 1 
          
;         end check joystick          
          
next
          rts