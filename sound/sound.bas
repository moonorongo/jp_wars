0 rem *** c64-wiki sound-demo ***
10 s = 54272: w = 17: on int(rnd(ti)*4)+1 goto 12,13,14,15
12 w = 33: goto 15
13 w = 65: goto 15
14 w = 129
15 poke s+24,15: poke s+5,97: poke s+6,200: poke s+4,w
16 for x = 0 to 255 step (rnd(ti)*15)+1
17 poke s,x :poke s+1,255-x
18 for y = 0 to 33: next y,x
19 for x = 0 to 200: next: poke s+24,0
20 for x = 0 to 100: next: goto 10
21 rem *** abort only with run/stop ! ***
