usepackage("units");
settings.render = -2;
size(16cm);

real s = 2;
real R = 0.5;
real off = s/10;

filldraw(box((0,0),(s,s)),gray,invisible);
draw(box((-s,-s),(s,s)), black);
draw((-s,0)--(s,0), dashdotted+black);
draw((0,-s)--(0,s), dashdotted+black);
string sym = "symmetry plane";
label(sym, (-s/2,0), S+0.5*W);
label(rotate(90)*sym, (0,-s/2), E+0.5*S);

draw(circle((0,0),R), black);
draw(rotate(45)*(-R,0)--(0,0), black, Arrows);
draw(rotate(45)*(-1.5*R,0)--(0,0), black);
label("$R=\unit[0.5]{m}$", rotate(45)*(-1.5*R,0), SW);

draw((0,0)--(R/2,0), black, Arrow);
label("$x$", (R/2,0), S);
draw((0,0)--(0,R/2), black, Arrow);
label("$y$", (0,R/2), W);

draw((-s,-s-off)--(s,-s-off), black, Arrows);
label("\unit[4.0]{m}", (0,-s-off), S);

for(int i=-4; i<5; ++i) {
  real y = i*s/4;
  draw((-s,y)--(-1.2*s,y), black, Arrow);
  draw((s,y)--(1.2*s,y), black, Arrow);
}
label("$\sigma=\unit[10]{kPa}$", (-1.2*s,0), W);
label("$\sigma=\unit[10]{kPa}$", (1.2*s,0), E);
