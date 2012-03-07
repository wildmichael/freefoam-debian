usepackage("pifont");

settings.render = -3;

// fiddling-parameter
real s = 8;
size(s*cm);
unitsize(1cm);

pair siz = (s, 554/429.*s);
draw(box(-siz/2,siz/2), invisible);
label(graphic("tut_ico_cavity_paraFoamCavityGlyphParameters_snapshot.png",
      format("width=%fcm",s)));
layer();

pen boldred = currentpen+red+linewidth()*3;

real h = 0.055s;
real w = 0.125s;

draw(shift((-0.5,0.632)*s)*xscale(1.75)*box((0,-h),(w,0)), boldred);
label("\ding{182}", (-0.5,0.632)*s+h*S,SE);

draw(shift((-0.01,0.332)*s)*xscale(3.55)*box((0,-h),(w,0)), boldred);
label("\ding{183}", (-0.01,0.332)*s+h*S,SW);

draw(shift((-0.13,-0.265)*s)*xscale(4.5)*box((0,-h),(w,0)), boldred);
label("\ding{184}", (-0.13,-0.265)*s,NW);

draw(shift((-0.13,-0.333)*s)*xscale(4.5)*box((0,-h),(w,0)), boldred);
label("\ding{185}", (-0.13,-0.333)*s+h*S,SW);
