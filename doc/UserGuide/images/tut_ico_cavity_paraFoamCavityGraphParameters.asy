usepackage("pifont");

settings.render = -3;

// fiddling-parameter
real s = 8;
size(s*cm);
unitsize(1cm);

pair siz = (s, 554/429.*s);
draw(box(-siz/2,siz/2), invisible);
label(graphic("tut_ico_cavity_paraFoamCavityGraphParameters_snapshot.png",
      format("width=%fcm",s)));
layer();

pen boldred = currentpen+red+linewidth()*3;

real h = 0.055s;
real w = 0.125s;

draw(shift((-0.208,0.91)*s)*xscale(1.66)*box((0,-h),(w,0)), boldred);
label("\ding{182}", (-0.208,0.91)*s+h*S,SW);

draw(shift((0.015,0.817)*s)*xscale(3.55)*box((0,-h),(w,0)), boldred);
label("\ding{183}", (0.015,0.817)*s+h*S,SW);

draw(shift((-0.44,0.547)*s)*xscale(3)*box((0,-h),(w,0)), boldred);
label("\ding{184}", (-0.44,0.547)*s+h*S,SW);

draw(shift((-0.03,0.547)*s)*xscale(3.66)*box((0,-h),(w,0)), boldred);
label("\ding{185}", (-0.03,0.547)*s+h*S+3.66*w*E,SE);

draw(shift((-0.44,0.026)*s)*xscale(4.7)*box((0,-h),(w,0)), boldred);
label("\ding{186}", (-0.44,0.026)*s+h/2*S,W);

draw(shift((0.045,-0.46)*s)*scale(3.15,1.25)*box((0,-h),(w,0)), boldred);
label("\ding{187}", (0.045,-0.46)*s+1.25/2*h*S,W);

draw(shift((0.045,-0.635)*s)*scale(3.15,1.25)*box((0,-h),(w,0)), boldred);
label("\ding{188}", (0.045,-0.635)*s+1.25/2*h*S,W);

draw(shift((0.045,-0.72)*s)*scale(3.15,1.25)*box((0,-h),(w,0)), boldred);
label("\ding{189}", (0.045,-0.72)*s+1.25/2*h*S,W);
