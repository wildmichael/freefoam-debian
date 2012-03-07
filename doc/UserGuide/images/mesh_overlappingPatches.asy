settings.render = -2;
size(9cm);

path patch1 = (0,0)--E+0.3N--0.9E+N--0.3W+0.8N--cycle;
path patch2 = 0.5E+0.2N--0.9E+0.4N--0.5E+1.2N--N--cycle;
filldraw(patch1, lightgray, black);
filldraw(patch2, lightgray, black);
pair[] cuts = intersectionpoints(patch1, patch2);
filldraw(0.5E+0.2N--0.9E+0.4N--cuts[0]--cuts[1]--cycle, gray, black);

label("patch 1", 0.3NE);
label("patch 2", N+0.3E);

real s = 0.06;
filldraw(shift(0.1S)*scale(s)*unitsquare, lightgray);
label("region of internal connection faces", 0.1S+s*E, NE);
filldraw(shift(0.2S)*scale(s)*unitsquare, gray);
label("region of external bounary faces", 0.2S+s*E, NE);
