// fiddling-parameter
real s = 20;
size(s*cm);
unitsize(1cm);

pair siz = (425/1339*s, s);
draw(box(-siz/2,siz/2), invisible);
label(graphic("post_displayPanel-snapshot.png", format("height=%fcm",s)));
layer();

real x1 = -3.7;
real x2 = -2.9;
real y = 8.6;
draw((x1,y)--(x2,y));
label("View case data", (x1,y), W);

y = 5.8;
draw((x1,y)--(x2,y));
label("Colour geometry/entity by...", (x1,y), W);

y = 5.3;
draw((x1,y)--(-1.5,y));
label("Set colour map range/appearance", (x1,y), W);

y = 1.8;
draw((x1,y)--(x2,y));
label("Outline, surface, wireframe or points", (x1,y), W);

y = 1.3;
draw((x1,y)--(x2,y));
label("Data interpolation method", (x1,y), W);

y = -0.4;
draw((x1,y)--(x2,y));
label(minipage("\raggedleft Change image opacity\\
                \emph{e.g.} to make translucent",130), (x1,y), W);

y = -8.8;
real dy = 0.7;
real dx = 0.4*abs(x2-x1);
draw((x1,y)--(x1+dx,y)--(x1+dx,y+dy)--(x2,y+dy)^^
             (x1+dx,y)--(x1+dx,y-dy)--(x2,y-dy));
label("Geometry manipulation tools", (x1,y), W);
