tickGenerator:
{
// tick4 --------------------------------------
          ldx tick4
          dex
          stx tick4
          cpx #$ff
          bne !next+
          
          ldx #3
          stx tick4 
!next:

// tick64 ------------------------------------
          ldx tick64
          dex
          stx tick64
          cpx #$ff
          bne !next+
          
          ldx #64
          stx tick64 


!next:
          rts
}          

