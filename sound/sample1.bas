10 rem subir el emulador al 400%
20 for l = 0 to 28 : poke 54272+l,0 : next
25 poke 54296, 15 + 16
30 poke 54273, 100 
35 poke 54272, 0: rem freq 1024 hz
40 poke 54277, 0*16+0 : rem atack decay 0
50 poke 54278, 15*16+9 : rem max vol release full
60 poke 54295,0*16+1
65 poke 54294,50
70 poke 54276, 33 : rem triangle waveform, start
80 for i = 100 to 0 step -10
90 poke 54273, i
100 next
130 poke 54276, 32 : rem turn off sound
