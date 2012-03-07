// fiddling-parameter
real s = 15;
size(s*cm);
unitsize(1cm);

pair siz = (s, 113/992*s);
draw(box(-siz/2,siz/2), dotted);
label(graphic("post_paraviewToolbars-snapshot.png", format("width=%fcm",s)));
layer();

path basebrace = (-1,0)--(-1,0.2)--(1,0.2)--(1,0);
path[] brace1 = shift((0,-0.4))*basebrace^^(0,-0.2)--(0,0);
path[] brace2 = shift((0,-0.9))*basebrace^^(0,-0.7)--(0,0);
path[] brace3 = shift((0.52,-1.7))*basebrace^^(0,-1.5)--(0,0);
path[] brace4 = shift((0,-1.2))*basebrace^^(0,-1)--(0,0);
path[] brace5 = shift((0,-1.7))*basebrace^^(0,-1.5)--(0,0);

draw(shift((-5.1,1.8))*xscale(2.1)*brace2);
label("Main Controls", (-5.1,1.8), N);

draw(shift((-1.25,1.3))*xscale(1.6)*brace1);
label("Selection Controls", (-1.25,1.3), N);

draw(shift((2.05,1.8))*xscale(1.6)*brace2);
label("VCR Controls", (2.05,1.8), N);

draw(shift((5.6,1.3))*xscale(1.8)*brace1);
label("Current Time Controls", (5.6,1.3), N);


draw(shift((-4.4,-1.3))*rotate(180)*xscale(2.9)*brace1);
label("Common Filters", (-4.4,-1.3), S);

draw(shift((-1,-1.8))*rotate(180)*xscale(4.15)*brace3);
label("Active Variable Controls $|$ Representation", (-1,-1.8), S);

draw(shift((3.25,-1.3))*rotate(180)*xscale(2.1)*brace4);
label("Camera Controls", (3.25,-1.3), S);

draw(shift((6.5,-1.8))*rotate(180)*xscale(1)*brace5);
label("Centre of Rotation Controls", (6.5,-1.8), S);
