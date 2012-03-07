usepackage("pifont");

settings.render = -3;

// fiddling-parameter
real s = 15;
size(s*cm);
unitsize(1cm);

pair siz = (s, 804/1117.*s);
draw(box(-siz/2,siz/2), invisible);
label(graphic("tut_ico_cavity_paraFoamCavityMesh_snapshot.png", format("width=%fcm",s)));
layer();

pen boldred = currentpen+red+linewidth()*3;

real h = 0.025s;
real w = 0.05s;

draw(shift(-0.415s,0.105s)*xscale(1.35)*box((0,-h),(w,0)), boldred);
label("\ding{182}", (-0.415s,0.105s),NW);

draw(shift(-0.3925s,-0.014s)*xscale(3.3)*box((0,-h),(w,0)), boldred);
label("\ding{183}", ((-0.3925+0.165)*s,-0.014s),NE);

draw(shift(-0.485s,-0.0415s)*xscale(3.3)*box((0,-h),(w,0)), boldred);
label("\ding{184}", (-0.485s,-0.0415s)+h*S+3.3*w*E,SE);

draw(shift(-0.38s,-0.253s)*xscale(4.78)*box((0,-h),(w,0)), boldred);
label("\ding{185}", (-0.38s,-0.253s),NW);
