usepackage("units");

settings.render = -2;
size(6cm);

real padding = 0.1;
real offset = 0.05;
real arrlen = 0.7;
real axlen = 0.3;

filldraw(box((-padding,-padding),(1+padding,1)), gray, gray);
filldraw(unitsquare, white, black);

draw((-padding-offset,0)--(-padding-offset,1), Arrows);
label("$\unit[0.1]{m}$", (-padding-offset, 0.5), W);

draw((0,-padding-offset)--(1,-padding-offset), Arrows);
label("$\unit[0.1]{m}$", (0.5,-padding-offset), S);

draw((0.5-arrlen/2,1+offset)--(0.5+arrlen/2,1+offset), Arrow);
label("$U_x=\unitfrac[1]{m}{s}$", (0.5,1+offset), N);

draw((0,axlen)--(0,0)--(axlen,0), black+2*linewidth(), Arrows);
label("$y$", (0,axlen), NE);
label("$x$", (axlen,0), NE);
