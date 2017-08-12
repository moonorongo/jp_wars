10 rem subir el emulador al 100%
20 for l = 0 to 28 : poke 54272+l,0 : next
25 poke 54296, 15
30 poke 54273, 3 
35 poke 54272, 0: rem freq 1024 hz
40 poke 54277, 0*16+0 : rem atack decay 0
50 poke 54278, 15*16+9 : rem max vol release full
70 poke 54276, 129 : poke 54276, 128
80 rem ver de poner algun filtro
