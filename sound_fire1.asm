{
    ldx fire1
    cpx #1
    beq turn_on_fire1
    jmp dec_freq_1
    
turn_on_fire1:    
    ldx #100
    stx sound_fire1_freq
    ldx #17
    stx sid_wave1
    
dec_freq_1:     
    ldx sound_fire1_freq
    cpx #0
    beq turn_off_fire1
    
    stx sid_hfreq1
    dec sound_fire1_freq
    dec sound_fire1_freq
    jmp exit
    
turn_off_fire1:    
    ldx #16
    stx sid_wave1
    
exit: 
}
