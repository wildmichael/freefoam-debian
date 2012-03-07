usepackage("units");

settings.render = -2;
size(14cm);

real s = 0.584;        // domain size
real wh = 0.292;       // water height
real ww = 0.1461;      // water width
real dx = ww + 0.1459; // dam x-start
real dh = 0.048;       // dam height
real dw = 0.024;       // dam width

real off = s/30;

filldraw(box((-off,-off),(s+off,s)),gray,gray);
filldraw((0,s)--(0,0)--(dx,0)--(dx,dh)--(dx+dw,dh)--(dx+dw,0)--
              (s,0)--(s,s)--cycle,white,black);
filldraw(box((0,0),(ww,wh)),red,black);

draw((0,s+off)--(s,s+off), Arrows);
label("$\unit[0.584]{m}$", (s/2,s+off), N);

draw((s+2*off,0)--(s+2*off,s), Arrows);
label("$\unit[0.584]{m}$", (s+2*off,s/2), E);

draw((-2*off,0)--(-2*off,wh), Arrows);
label("$\unit[0.292]{m}$", (-2*off,wh/2), W);

draw((-2*off,0)--(-2*off,wh), Arrows);
label("$\unit[0.292]{m}$", (-2*off,wh/2), W);

draw((0,-2*off)--(ww,-2*off), Arrows);
label("$\unit[0.1461]{m}$", (ww/2,-2*off), S);

draw((ww,-2*off)--(dx,-2*off), Arrows);
label("$\unit[0.1459]{m}$", (ww+(dx-ww)/2,-2*off), S);

draw((dx+dw+s/20,-2*off)--(dx+dw,-2*off), Arrow);
label("$\unit[0.024]{m}$", (dx+dw+s/20,-2*off), E);

draw((dx+dw+s/20,dh+s/20)--(dx+dw+s/20,dh), Arrow);
draw((dx+dw+s/20,-s/20)--(dx+dw+s/20,0), Arrow);
label("$\unit[0.048]{m}$", (dx+dw,dh/2), E);

label("water column", (0,wh), NE);
