settings.render = -2;
unitsize(2.2cm);

real x1 = 0;
real x2 = 2.5;
real x3 = 5.5;

real y1 = 0;
real y2 = -1.5;
real y3 = -3;
real y4 = -3.5;

real y12 = y1+(y2-y1)/2;
real y23 = y2+(y3-y2)/2;
real y34 = y3+(y4-y3)/2;

draw((x1,y1)--(x3,y1), dashed);
label("Base type", (x1,y12), E);
label(minipage("\centering\tt
                 patch\\
                 wall"), (x2, y12));
draw((x2,y12-0.3)--(x2,y2+0.1), Arrow);
label(minipage("\centering\tt
                symmetry\\
                empty\\
                wedge\\
                cyclic\\
                \ \\
                processor"), (x3, y12), W);

draw((x1,y2)--(x3,y2), dashed);
label("Primitive type", (x1,y23), E);
label(minipage("\centering\tt
                fixedValue\\
                fixedGradient\\
                zeroGradient\\
                mixed\\
                directionMixed \\
                calculated"), (x2, y23));
draw(shift(0.8W)*((x3,y2-0.1)--(x3,y34)), Arrow);
draw((x1,y3)--(x3,y3), dashed);
label("Derived type", (x1,y34), E);
label(minipage("\centering
                \emph{e.g.} \tt inletOutlet"), (x2, y34));
draw((x1,y4)--(x3,y4), dashed);
