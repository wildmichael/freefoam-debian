usepackage("pifont");

settings.render = -3;

// fiddling-parameter
real s = 8;
size(s*cm);
unitsize(1cm);

pair siz = (s, 623/431.*s);
draw(box(-siz/2,siz/2), invisible);
label(graphic("tut_ico_cavity_paraFoamCavityPContourDisplay_snapshot.png",
      format("width=%fcm",s)));
layer();

pen boldred = currentpen+red+linewidth()*3;

real h = 0.055s;
real w = 0.125s;

draw(shift((-0.272,0.71)*s)*xscale(1.35)*box((0,-h),(w,0)), boldred);
label("\ding{182}", (-0.272,0.71)*s+h*S,SW);

draw(shift((-0.22,0.398)*s)*xscale(3.4)*box((0,-h),(w,0)), boldred);
label("\ding{183}", (-0.22,0.398)*s+h*S,SW);

draw(shift((0.05,0.327)*s)*xscale(3)*box((0,-h),(w,0)), boldred);
label("\ding{184}", (0.05,0.327)*s+h*S+3*E,SE);

draw(shift((-0.195,-0.223)*s)*xscale(4.95)*box((0,-h),(w,0)), boldred);
label("\ding{185}", (-0.195,-0.223)*s+h*S+4.95*E,SE);
