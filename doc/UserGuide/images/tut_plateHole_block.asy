import graph;

usepackage("units");
settings.render = -2;
size(10cm);

// side length
real s = 2;
// radius of hole
real R = 0.5;

// 45 deg points on arcs for reuse
pair arcp1 = rotate(45)*(R,0);
pair arcp2 = rotate(45)*(2*R,0);

// index axes
path base_ax = (R/2,0)--(0,0)--(0,R/2);
path[] ax = {
  shift(arcp1)*rotate(45)*base_ax,
  shift((R,0))*base_ax,
  shift((2*R,0))*base_ax,
  shift(arcp2)*base_ax,
  shift((0,2*R))*base_ax
};

// label positions for index axes
pair[][] idx_pos = {
  {rotate(45)*2*SW, rotate(45)*2*SE},
  {1.2*SW, 1.2*SE},
  {1.2*SW, 1.2*SE},
  {1.2*SW, 1.2*SE},
  {1.2*SW, 1.2*SE},
};

// draw index axes
draw(arc((0,0), R, 0, 90), black);
draw(arc((0,0), 2*R, 0, 90), black);
draw(arcp1--arcp2, black);
draw((0,R)--(0,s)--(s,s)--(s,0)--(R,0), black);
draw(arcp2--(s,arcp2.y), black);
draw(arcp2--(arcp2.x,s), black);

// label index axes
for(int i=0; i<ax.length; ++i) {
  draw(ax[i], black, Arrows);
  label("$i_1$", point(ax[i],0), idx_pos[i][0]);
  label("$i_2$", point(ax[i],2), idx_pos[i][1]);
}

// label blocks
pair[] label_pos = {
  rotate(3/4*90)*(1.5*R,0),
  rotate(1/4*90)*(1.5*R,0),
  ((2*R+s), arcp2.y)/2,
  (arcp2+(s,s))/2,
  ((0,2*R)+(arcp2.x,s))/2
};
for(int i=0; i < label_pos.length; ++i) {
  label(format("$%d$", i), label_pos[i]);
  draw(circle(label_pos[i], 0.07), black);
}

// put crosses on arcs
label("$\times$", rotate(-22.5)*arcp1);
label("$\times$", rotate(22.5)*arcp1);
label("$\times$", rotate(-22.5)*arcp2);
label("$\times$", rotate(22.5)*arcp2);

// label corners
pair[][] corners = {
  {(R,0), S},
  {(2*R,0), S},
  {(s,0), S},
  {(s,arcp2.y), E},
  {arcp2, 2*W},
  {arcp1, SW},
  {(s,s), NE},
  {(arcp2.x,s), N},
  {(0,s), NW},
  {(0,2*R), W},
  {(0,R), W}
};

for(int i=0; i<corners.length; ++i) {
  label(format("$%d$",i), corners[i][0], corners[i][1]);
}

// label patches
label("down", (corners[0][0]+corners[1][0])/2, 5*S);
label("down", (corners[1][0]+corners[2][0])/2, S);
label("right", (corners[2][0]+corners[3][0])/2, E);
label("right", (corners[3][0]+corners[6][0])/2, E);
label("up", (corners[6][0]+corners[7][0])/2, N);
label("up", (corners[7][0]+corners[8][0])/2, N);
label("left", (corners[8][0]+corners[9][0])/2, W);
label("left", (corners[9][0]+corners[10][0])/2, W);
label("hole", arcp1, 4*SW);

// draw coordinate axes
draw(base_ax, black, Arrows);
label("$x$", point(base_ax,0), 2*SW);
label("$y$", point(base_ax,2), 2*SE);
