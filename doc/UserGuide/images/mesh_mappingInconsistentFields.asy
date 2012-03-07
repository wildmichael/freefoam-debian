settings.render = -2;
size(16cm);

pair[] p1 = {
  (0.6, 0.56),
  (1.8, 1.26),
  (2.8, 0.7),
  (3.2, 1.96),
  (2,   3),
  (0.9, 3.1),
  (0.2, 1.76)
  };

real off = 0.03;
pair[] p2 = {
  (0.5,  0),
  (1.8,  1.26)+off*S,
  (2.8,  0.7)+off*SSE,
  (3.2,  1.96)+off*ENE,
  (2,    3)+off*NNE,
  (1.24, 2.94),
  (0,    1.22)
  };

path patch1 = p1[0]--p1[1]--p1[2]--p1[3]--p1[4]--p1[5]--p1[6]--cycle;
path patch2 = p2[0]--p2[1]--p2[2]--p2[3]--p2[4]--p2[5]--p2[6]--cycle;

real[][] r = intersections(patch1, patch2);
filldraw(buildcycle(subpath(patch1, r[0][0], r[1][0]),
     subpath(patch2, r[0][1], r[1][1])), mediumgray, invisible);

draw(patch1);
draw(patch2, dashed);

draw(point(patch1,6.8){SW}::(1,0.2){right});
draw(point(patch1,0.4)--(1.5,0.45));
label(minipage("Internal target patches:\\
                can be mapped using \tt cuttingPatches", 200),
      (1,0.2), E);

draw(point(patch1,1.7){S}::(3.3,0.6){NE});
draw(point(patch1,2.5)--(3.3,1.05));
draw(point(patch1,3.4){NE}::(3.6,1.05){S});
label(minipage("Coincident patches:\\
                can be mapped using \tt patchMap", 160),
      (3.1,0.8),E);

draw((0.5,-0.2)--(0.8,-0.2), dashed);
label("Source field geometry", (0.8,-0.2), E);
draw((0.5,-0.35)--(0.8,-0.35));
label("Target field geometry", (0.8,-0.35), E);
