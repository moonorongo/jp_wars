{
    ldx fire2
    cpx #1
    beq turn_on_fire2
    jmp dec_freq_2
    
turn_on_fire2:    
    ldx #100
    stx sound_fire2_freq
    ldx #33
    stx sid_wave2
    
dec_freq_2:     
    ldx sound_fire2_freq
    cpx #0
    beq turn_off_fire2
    
    stx sid_hfreq2
    dec sound_fire2_freq
    dec sound_fire2_freq
    jmp exit
    
turn_off_fire2:    
    ldx #32
    stx sid_wave2
    
exit: 
}
