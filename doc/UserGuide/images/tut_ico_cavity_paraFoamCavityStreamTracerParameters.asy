usepackage("pifont");

settings.render = -3;

// fiddling-parameter
real s = 8;
size(s*cm);
unitsize(1cm);

pair siz = (s, 753/507.*s);
draw(box(-siz/2,siz/2), invisible);
label(graphic("tut_ico_cavity_paraFoamCavityStreamTracerParameters_snapshot.png",
      format("width=%fcm",s)));
layer();

pen boldred = currentpen+red+linewidth()*3;

real h = 0.055s;
real w = 0.125s;

draw(shift((-0.49,0.735)*s)*xscale(1.45)*box((0,-h),(w,0)), boldred);
label("\ding{182}", (-0.49,0.735)*s+h*S,SE);

draw(shift((0.007,-0.215)*s)*xscale(3.6)*box((0,-h),(w,0)), boldred);
label("\ding{183}", (0.007,-0.215)*s,NW);

draw(shift((-0.35,-0.333)*s)*scale(6.45,1.9)*box((0,-h),(w,0)), boldred);
label("\ding{184}", (-0.35,-0.333)*s+1.9h*S,SW);

draw(shift((0.01,-0.638)*s)*xscale(3.55)*box((0,-h),(w,0)), boldred);
label("\ding{185}", (0.01,-0.638)*s+h/2*S,W);

draw(shift((-0.055,0.033)*s)*xscale(4.1)*box((0,-h),(w,0)), boldred);
label("\ding{186}", (-0.055,0.033)*s+h*S,SW);

draw(shift((-0.055,0.262)*s)*xscale(4.1)*box((0,-h),(w,0)), boldred);
label("\ding{187}", (-0.055,0.262)*s+h/2*S,W);

draw(shift((-0.055,0.433)*s)*xscale(4.1)*box((0,-h),(w,0)), boldred);
label("\ding{188}", (-0.055,0.433)*s+h/2*S,W);

draw(shift((-0.055,0.375)*s)*xscale(4.1)*box((0,-h),(w,0)), boldred);
label("\ding{189}", (-0.055,0.375)*s+h/2*S,W);
